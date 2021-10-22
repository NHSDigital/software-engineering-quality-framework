#!/usr/bin/env bash

# Script created to launch Jmeter tests directly from the current terminal without accessing the jmeter master pod.
# It requires that you supply the path to the jmx file
# After execution, test script jmx file may be deleted from the pod itself but not locally.

jmx="$1"
[ -n "$jmx" ] || read -p 'Enter path to the jmx file ' jmx

if [ ! -f "$jmx" ];
then
    echo "Test script file was not found in PATH"
    echo "Kindly check and input the correct file path"
    exit
fi

test_name="$(basename "$jmx")"

#Get Master pod details
master_pod=`kubectl get po | grep jmeter-master | awk '{print $1}'`

# Copy JMX file onto master
kubectl cp "$jmx" "$master_pod:/$test_name"

## Echo Starting Jmeter load test
kubectl exec -ti $master_pod -- /bin/bash /load_test "$test_name"
