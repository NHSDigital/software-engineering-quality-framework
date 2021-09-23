#!/bin/bash

MAX_RETRIES=45
SLEEP_TIME=5

CANARY_NAME=${1?You must pass in the name of the canary to check in quotes}
CANARY_STATE=${2?You must pass in the canary state to check for}

RETRY_COUNT=0
while [[ ( $RETRY_COUNT -lt $MAX_RETRIES ) ]]
do
    AWSCLI_OUTPUT=$(aws synthetics describe-canaries-last-run | jq -r --arg jq_canaryname "$CANARY_NAME" '.CanariesLastRun[] | select (.CanaryName == $jq_canaryname) | .LastRun.Status.State ')
    if [[ $AWSCLI_OUTPUT == $CANARY_STATE ]]
    then
      echo "AWSCLI_OUTPUT for $CANARY_NAME is $CANARY_STATE, ready to continue to next step in pipeline"
      exit 0
    else
      echo "$CANARY_NAME not in required state, $CANARY_STATE"
      ((RETRY_COUNT=RETRY_COUNT + 1))
      echo "RETRIES: $RETRY_COUNT, waiting $SLEEP_TIME seconds"
      sleep $SLEEP_TIME
    fi
done

if [[ $RETRY_COUNT -eq $MAX_RETRIES  ]]
then
  ((TIMEOUT=SLEEP_TIME * MAX_RETRIES))
  echo "$CANARY_NAME not in required state within $TIMEOUT seconds"
  exit 1
fi
