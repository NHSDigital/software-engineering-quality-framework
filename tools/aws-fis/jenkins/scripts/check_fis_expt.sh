#!/bin/bash

EXPT_ID=${1?You must pass in the expt. id}
SLEEP_TIME=${2?You must enter the time to sleep between checks in seconds, e.g. 5}
MAX_RETRIES=${3?You must enter the max number of retries, e.g. 120}

RETRY_COUNT=0
while [[ ( $RETRY_COUNT -lt $MAX_RETRIES ) ]]
do
    AWSCLI_OUTPUT=$(aws fis get-experiment --id $EXPT_ID | jq -r '.experiment.state.status')
    echo $AWSCLI_OUTPUT
    if [[ $AWSCLI_OUTPUT == 'completed' ]]
    then
      echo "Experiment completed"
      exit 0
    elif [[ $AWSCLI_OUTPUT == 'stopped' ]]; then
      echo "Experiment stopped, alarm triggered!"
      exit 1
    elif [[ $AWSCLI_OUTPUT == 'failed' ]]; then
      echo "Experiment failed"
      exit 1
    else
      echo "Experiment still running"
      ((RETRY_COUNT=RETRY_COUNT + 1))
      echo "RETRIES: $RETRY_COUNT, waiting $SLEEP_TIME seconds"
      sleep $SLEEP_TIME
    fi
done

if [[ $RETRY_COUNT -eq $MAX_RETRIES  ]]
then
  ((TIMEOUT=SLEEP_TIME * MAX_RETRIES))
  echo "Experiment didn't complete or fail within $TIMEOUT seconds"
  exit 1
fi
