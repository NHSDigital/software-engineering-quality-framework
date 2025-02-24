The Terraform 0.13.6 example here deploys a stack containing:

* a lambda to monitor ACM certs in the same AWS account
* SNS topic and cloudwatch event rule for sending email notifications

The lambda also sends slack notifications but you will need to:

* add a secret to AWS Secrets Manager with the Slack webhook URL
* update the Slack channel & secret id in the python script:

  `"channel": "<INSERT SLACK CHANNEL>",`

  `pw_response = boto3.client('secretsmanager', region_name=AWS_REGION).get_secret_value(SecretId='<INSERT SECRET ID>')`
   
You will also need to set the appropriate values for the variables defined in variables.tf in the .tfvars file for your environment(s)

As it stands, the lambda warns when certs have 45 days left and sends a critical notification at 15 days until expiry.
