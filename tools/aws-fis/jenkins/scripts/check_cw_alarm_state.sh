#!/bin/bash

MAX_RETRIES=30
SLEEP_TIME=5

CW_ALARM_NAME=${1?You must pass in the name of the CloudWatch alarm to check in quotes}
CW_ALARM_STATE=${2?You must pass in the CloudWatch alarm state to check for}

RETRY_COUNT=0
while [[ ( $RETRY_COUNT -lt $MAX_RETRIES ) ]]
do
    AWSCLI_OUTPUT=$(aws cloudwatch describe-alarms | jq -r --arg jq_alarmname "$CW_ALARM_NAME" '.MetricAlarms[] | select (.AlarmName == $jq_alarmname) | .StateValue ')
    if [[ $AWSCLI_OUTPUT == $CW_ALARM_STATE ]]
    then
      echo "AWSCLI_OUTPUT for $CW_ALARM_NAME is $CW_ALARM_STATE, ready to continue to next step in pipeline"
      exit 0
    else
      echo "$CW_ALARM_NAME not in required state, $CW_ALARM_STATE"
      ((RETRY_COUNT=RETRY_COUNT + 1))
      echo "RETRIES: $RETRY_COUNT, waiting $SLEEP_TIME seconds"
      sleep $SLEEP_TIME
    fi
done

if [[ $RETRY_COUNT -eq $MAX_RETRIES  ]]
then
  ((TIMEOUT=SLEEP_TIME * MAX_RETRIES))
  echo "$CW_ALARM_NAME not in required state within $TIMEOUT seconds"
  exit 1
fi
