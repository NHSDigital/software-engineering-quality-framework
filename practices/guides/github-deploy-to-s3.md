# Deploy to an S3 bucket from GitHub

This guide gives a quick, secure way to build a simple static website in GitHub, and deploy it to an S3 bucket in AWS.

For that to work, GitHub needs permissions on the S3 bucket. The standard approach is to use a specific AWS access_key and secret_token. But, even if you use GitHub Secrets, you're still then exposing an access token to GitHub.

OIDC is an alternative approach whereby GitHub gets granted temporary access to a specific role in AWS. This further lets you limit that role using IAM: to specific buckets and actions.

The process flow for OIDC is:

1. GitHub Action triggers from your git commit
2. GitHub Action assumes a role in AWS
3. (behind the scenes, GitHub and AWS use OIDC: exchanging JWT tokens to grant GitHub temporary access to a specific role in AWS)
4. GitHub Action uses that role to copy files into an S3 bucket

One-time setup to get this working:

1. Define GitHub as an Identity Provider in your AWS account
2. Define what GitHub is allowed to do (IAM Role Policy)
3. Define the GitHub role (IAM Role)
4. Hook this into your GitHub Action

NB: You should script as much of this as possible, where it is safe to do so.

## Define GitHub as an identity provider in your AWS account

This is done by adding GitHub as an IdP Provider in AWS.

Follow steps to create IdP provider:
https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services


## Define what GitHub is allowed to do

This is done by creating an AWS Role Profile, stating exactly which buckets GitHub will be allowed to deploy into.

Create new Policy ("GitHubS3DeployPolicy")

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": [
                "arn:aws:s3:::your-s3-bucket/*",
                "arn:aws:s3:::your-s3-bucket"
            ]
        }
    ]
}
```

## Define the GitHub role

This is the role that GitHub will assume. It:

- Links to the policy created early
- Links to the github OIDC created early
- Explicitly states which GitHub repo, and branches are permitted

This page includes many options, including using Cognito, etc.
https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html

Below is a full, simple example that doesn't use Cognito.

Create a new Role ("GitHubS3DeployRole")
Trust policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<YOUR_AWS_ACCOUNT_NUMBER>:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
          "token.actions.githubusercontent.com:sub": "repo:<YOUR_GITHUB_ORG>/<YOUR_GITHUB_REPO>:ref:refs/heads/main"
        }
      }
    }
  ]
}
```
Attach the policy created earlier ("GitHubS3DeployPolicy")


## Hook this into your GitHub Action

Define two GitHub Secrets to hold the ASSUME_ROLE_ARN ("GitHubS3DeployRole" from earlier) and AWS_S3_BUCKET_NAME.
Use "aws-actions/configure-aws-credentials@v2" to assume that role.
Example below just syncs two folders into the s3 bucket.

```yaml
name: deploy-app

on:
  push:
    branches:
      - main

jobs:
  build:
    permissions:
        id-token: write
        contents: read
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - name: Checkout
        uses: actions/checkout@v3

      - name: Authenticate with AWS over OIDC
        uses: aws-actions/configure-aws-credentials@v2
        with:
          role-to-assume: ${{ secrets.ASSUME_ROLE_ARN }}
          role-session-name: mysessionname
          aws-region: eu-west-2
      - name: Copy files to the s3 website content bucket
        run:
          aws s3 sync myfolder s3://${{ secrets.AWS_S3_BUCKET_NAME }}/myfolder
          aws s3 sync myotherfolder s3://${{ secrets.AWS_S3_BUCKET_NAME }}/myotherfolder
```

All done!

## Testing

Some basic test cases below to make sure you've secured this properly. Add your own too.
You should look to automate these where possible.
I've included my specific tests, and results - may be some helpful notes in there.

Ensure success:

- GitHub: edit "view-stack/index.html"
- Commit to "main" branch
- Expecting:
  - Build should clearly pass
  - Build should be quick (<10 min)
  - Bucket contents updated
  - Bucket timestamp updated
  - No previous version stored in bucket (we're not versionsing)
- RESULT: PASS. Took 21 seconds, 18 of those in copying the files. Expect that to grow as files get bigger, but remain under 10 mins. Add a timeout to the GitHub action to enforce that time limit.

Ensure GitHub Action: only triggers on "main" branch:

- GitHub: make a new branch and commit
- Expecting:
  - Action does NOT trigger
  - S3 bucket is not updated
- Because:
  - Should only trigger on "main" branch (ci.yml:  on:push:branches: - main)
- RESULT: PASS

Ensure Role Policy: fails when has wrong S3 bucket name:

- AWS: edit "GitHubS3DeployPolicy". Change S3 bucket name to something random.
- Kick off another github workflow on "main"
- Expecting:
  - Build should clearly fail
  - Nothing redeployed to S3 bucket
- Because:
  - Role Policy says explicitly which bucket name this role is allowed to deploy into
  - Auth should still work, but aws s3 command should fail with access denied.
- RESULT: PASS
  - Run aws s3 sync view-stack s3://***/view-stack 
	10fatal error: An error occurred (AccessDenied) when calling the ListObjectsV2 operation: Access Denied 
	11Error: Process completed with exit code 1.

Ensure Role: fails when has wrong GitHub Repo name:

- AWS: edit "GitHubS3DeployRole" Trust Policy. Change GitHub Repo in "token.actions.githubusercontent.com:sub" to something random: "repo:NHSDigitalWRONG/tech-radar:ref:refs/heads/main"
- Kick off another github workflow on "main"
- Expecting:
  - Build should clearly fail
  - Nothing redeployed to S3 bucket
- Because:
  - Role's trust policy says explicitly which GitHub repo is allowed to use this role
- RESULT: PASS, with notes:
  - Authentication failed: Error: Not authorized to perform sts:AssumeRoleWithWebIdentity
  - But took 2min, seemed to be timing out / retrying

Ensure Role fails when has wrong GitHub Branch name:

- AWS: edit "GitHubS3DeployRole" Trust Policy. Change GitHub branch in "token.actions.githubusercontent.com:sub" to something random: "repo:NHSDigital/tech-radar:ref:refs/heads/mainWRONG"
- Kick off another github workflow on "main"
- Expecting:
  - Workflow SHOULD still trigger (GitHub action still has "main" as the branch to trigger on)
  - Build should clearly fail
  - Nothing redeployed to S3 bucket
- Because:
  - Role's trust policy says explicitly which branches of the GitHub repo are allowed to use this role
- RESULT: PASS, with notes:
  - Authentication failed: Error: Not authorized to perform sts:AssumeRoleWithWebIdentity
  - But took 2min, seemed to be timing out / retrying
