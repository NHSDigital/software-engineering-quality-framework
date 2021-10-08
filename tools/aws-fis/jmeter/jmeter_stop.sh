#!/usr/bin/env bash
#Script writtent to stop a running jmeter master test
#Kindly ensure you have the necessary kubeconfig

master_pod=`kubectl get po | grep jmeter-master | awk '{print $1}'`

kubectl exec -ti $master_pod -- bash /jmeter/apache-jmeter-5.0/bin/stoptest.sh
