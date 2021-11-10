# Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import json
import urllib3
import boto3
import os
from datetime import datetime, timedelta, timezone

# -------------------------------------------
# setup global data
# -------------------------------------------
http = urllib3.PoolManager()
utc = timezone.utc
date = datetime.now().date()
today = datetime.now().replace(tzinfo=utc)
AWS_REGION = 'eu-west-2'

if os.environ.get('EXPIRY_DAYS') is None:
    expiry_days = 45
else:
    expiry_days = int(os.environ['EXPIRY_DAYS'])

if os.environ.get('CRITICAL_EXPIRY_DAYS') is None:
    critical_expiry_days = 15
else:
    critical_expiry_days = int(os.environ['CRITICAL_EXPIRY_DAYS'])

expiry_window = date + timedelta(days=expiry_days)
critical_expiry_window = today + timedelta(days=critical_expiry_days)


def lambda_handler(event, context):
    # if this is coming from the ACM event, its for a single certificate
    if event['detail-type'] == "ACM Certificate Approaching Expiration":
        response = handle_single_cert(event)
    return {
        'statusCode': 200,
        'body': response
    }


def handle_single_cert(event):
    cert_client = boto3.client('acm')
    cert_details = cert_client.describe_certificate(CertificateArn=event['resources'][0])
    result = check_cert(cert_details)
    return result


def check_cert(cert_details):
    result = 'The following certificate is expiring within '

    if cert_details['Certificate']['NotAfter'].date() == expiry_window:
        result = result + str(expiry_days) + ' days: ' + \
                 cert_details['Certificate']['DomainName'] + \
                 ' (' + cert_details['Certificate']['CertificateArn'] + ') '
        send_msg_slack(result)
        send_email(result)
    elif cert_details['Certificate']['NotAfter'] < critical_expiry_window:
        result = ':bomb: CRITICAL:' + result + str(critical_expiry_days) + ' days: ' + \
                 cert_details['Certificate']['DomainName'] + \
                 ' (' + cert_details['Certificate']['CertificateArn'] + ') '
        send_msg_slack(result)
        send_email(result)

    return result


def send_email(result):
    sns_client = boto3.client('sns')
    sns_client.publish(TopicArn=os.environ['SNS_TOPIC_ARN'], Message=result.replace(":bomb: ", ""),
                                  Subject='Certificate Expiration Notification')


def send_msg_slack(result):

   url= get_slack_url()
   if(url is None):
      print ('unable to send slack message, slack url not set')
   else:     
      msg = {
        "channel": "#texas-alerts",
        "username": "ACM_Expiry",
        "text": result,
        "icon_emoji": ""
      }

      encoded_msg = json.dumps(msg).encode('utf-8')
      resp = http.request('POST', url, body=encoded_msg)
      print({
        "message": result,
        "status_code": resp.status,
        "response": resp.data
      })

def get_slack_url():
   slack_url = None
   pw_response = boto3.client('secretsmanager', region_name=AWS_REGION).get_secret_value(SecretId='<INSERT SECRET ID>')
   secrets = pw_response['SecretString']
   secret_dict= json.loads(secrets)   
   slack_url_key = 'slack_hook_url'
   if slack_url_key in secret_dict:
      slack_url = secret_dict[slack_url_key]
      print('slack hook url'+slack_url)
   else:
      print(slack_url_key+' not declared in AWS Secrets')
   
   return slack_url
