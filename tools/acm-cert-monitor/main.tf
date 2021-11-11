##################
# Lambda
##################
data "archive_file" "acm_cert_monitor_zip" {
  type        = "zip"
  source_dir  = "${path.module}/resources"
  output_path = "${path.module}/.terraform/archive_files/acm_cert_monitor.zip"
}

resource "aws_lambda_function" "acm_cert_monitor" {
  filename         = data.archive_file.acm_cert_monitor_zip.output_path
  function_name    = "${var.name_prefix}-acm-cert-monitor"
  role             = aws_iam_role.acm_cert_monitor_role.arn
  handler          = "acm_cert_monitor.lambda_handler"
  source_code_hash = data.archive_file.acm_cert_monitor_zip.output_base64sha256
  runtime          = "python3.7"
  timeout          = "180"

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.acm_cert_monitor_sns.arn
    }
  }
}

##################
# Event
##################
resource "aws_cloudwatch_event_rule" "acm_expiry_notification" {
  name          = "${var.name_prefix}-acm-cert-expiry-monitor"
  description   = "Event to monitor ACM expiry certs"
  event_pattern = <<EOF
{
  "source": [
    "aws.acm"
  ],
  "detail-type": [
    "ACM Certificate Approaching Expiration"
  ]
}
EOF
}

resource "aws_cloudwatch_event_target" "acm_cert_monitor_lambda" {
  target_id = "SendToLambda"
  rule      = aws_cloudwatch_event_rule.acm_expiry_notification.name
  arn       = aws_lambda_function.acm_cert_monitor.arn
}

resource "aws_lambda_permission" "acm_cloudwatch_invoke_function" {
  statement_id  = "AllowACMLambdaExecutionFromCloudWatchEvent"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.acm_cert_monitor.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.acm_expiry_notification.arn
}

##################
# Notification
##################
resource "aws_sns_topic" "acm_cert_monitor_sns" {
  name         = "${var.name_prefix}-acm-cert-monitor"
  display_name = var.name_prefix
  kms_master_key_id = "alias/aws/sns"
}

##################
#  Role/Policies
##################
resource "aws_iam_role" "acm_cert_monitor_role" {
  path = "/"
  name = "${var.name_prefix}-acm-cert-monitor-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Action": [
        "sts:AssumeRole"
      ]
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "acm_cert_monitor_policy" {
  role = aws_iam_role.acm_cert_monitor_role.id
  name = "${var.name_prefix}-acm-cert-monitor-policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["logs:*"],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "acm:DescribeCertificate",
                "acm:GetCertificate",
                "acm:ListCertificates",
                "acm:ListTagsForCertificate"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "SNS:Publish",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "SecurityHub:BatchImportFindings",
                "SecurityHub:BatchUpdateFindings",
                "SecurityHub:DescribeHub"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "cloudwatch:ListMetrics",
            "Resource": "*"
        }
    ]
}
EOF
}