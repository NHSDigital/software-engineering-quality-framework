# Git-Secrets examples

This folder comprises examples for implementing AWSLabs Git-Secrets, which is our default implementation for [secrets scanning](../../quality-checks.md). As with any default, we expect teams to resolve any caveats as they best see fit, and of course to contribute to these examples.

## Why secrets scanning

Although we might be re-stating the obvious here, there's two main goals to consistent secrets scanning:

1. Remove any secrets that may have been checked into the codebase in the past.
2. Prevent any new secrets from making it into the codebase.

Essentially, we want to avoid the NHS facing [potentially dire consequences](https://www.zdnet.com/article/data-of-243-million-brazilians-exposed-online-via-website-source-code/) due to exposure of secrets.

## How to get started

If your team isn't doing secrets scanning at all yet, the fundamental first step is to understand the current state of the art. Use the following guides to set up and run Git-Secrets for a nominated team member:

* [macOS](README-mac-workstation.md)
* [Linux/WSL](README-linux-workstation.md)
* [Windows](README-windows-workstation.md)

Run the tooling, and ascertain whether there's any immediate actions to be taken.

## Ongoing checks

Once you've verified there's no urgent actions on your code, the next steps towards getting to green are:

1. Ensure every team member is doing local scans. Stopping secrets before code has been committed is cheap, removing them from git history is expensive.
2. Run these same scripts as part of your deployment pipelines as a second line of defence.

## Other ways of keeping credentials out of your code

### Consider using OIDC Authentication instead of passwords

OpenID Connect allows federated authentication from pipeline workflows to AWS and Azure without storing credentials in repository secrets at all, so no expiry to manage. GitHub documentation for achieving this for:

* [AWS](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
* [Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
* [Google](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-google-cloud-platform)

Configuration for OIDC is light. See the below example GitHub Actions workflow excerpt which connects to both AWS and Azure:

```yaml
steps:
  - name: Checkout
    uses: actions/checkout@v3
​
  - name: Configure AWS STS credentials via OIDC
    uses: aws-actions/configure-aws-credentials@v1
    with:
      role-to-assume: ${{ secrets.AWS_ROLE_ID }}
      aws-region: eu-west-2
​
  - name: Configure Azure identity token via OIDC
    uses: azure/login@v1
    with:
      client-id: ${{ secrets.AZ_CLIENT_ID }}
      tenant-id: ${{ secrets.AZ_TENANT_ID }}
      allow-no-subscriptions: true
 ```
