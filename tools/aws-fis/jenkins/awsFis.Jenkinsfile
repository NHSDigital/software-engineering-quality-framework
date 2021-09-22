// AWS vars
def awsRegion = 'eu-west-2'
// These must match the descriptions/names of your Cloudwatch alarms and FIS 
// expt. templates - these should also be managed from code using Terraform
def cloudwatchAlarm1 = 'HTTP 500 errors > 0'
def cloudwatchAlarm2 = 'Average response time > 5s'
def exptTmplDesc1 = 'eks-nodes-high-memory'
def exptTmplDesc2 = 'eks-nodes-high-cpu'
def exptTmplDesc3 = 'AZ failure'
def canaryName = 'Get appx homepage'

// Jenkins variables
def jenkinsSlaveLabel = 'jenkins-slave'
def scriptsDir = 'scripts'

// Service Team vars
def serviceTeamShortname = 'teamx'
def appName = 'appx'
def rdsInstance = "${appName}-postgres"

// jMeter vars
def jmeterDir = 'jmeter'
def jmeterNamespace = "${serviceTeamShortname}-jmeter"
def jmxFile = "${appName}-loadtest.jmx"

// Placeholder for code to set variables for each environment, e.g. could be 
// derived from Jenkins job name so that one Jenkinsfile can be used for all environments
def envName = 'preprod'

properties([disableConcurrentBuilds()])
properties([buildDiscarder(logRotator(numToKeepStr: '15'))])

node( jenkinsSlaveLabel ) {

  stage('Checkout') {
    echo 'Git repository checkout...'
    checkout scm
  }

  stage("Authenticate to AWS/k8s") {
    echo "placeholder"
  }

  stage("Deploy ${appName}") {
    echo "placeholder"
  }
  
  // Get a performance baseline before you run start running FIS tests
  stage("Run Jmeter without FIS"){
  // Wrap in code that injects credentials so you can run kubectl
    sh """kubectl config set-context --current --namespace=${jmeterNamespace}"""
    dir ( jmeterDir ){
      // Ensure any previous tests have stopped before starting a new test
      sh """./jmeter_stop.sh"""
      sh """./start_test.sh ${jmxFile}"""
    }
  }
  
  // Run jMeter in parallel with FIS tests
  parallel 'Jmeter': {
    stage("Run Jmeter"){
      // Wrap in code that injects credentials so you can run kubectl
      sh """kubectl config set-context --current --namespace=${jmeterNamespace}"""
      dir ( jmeterDir ){
        // Ensure any previous tests have stopped before starting a new test
        sh """./jmeter_stop.sh"""
        sh """./start_test.sh ${jmxFile}"""
      }
    }
  }, "FIS - ${exptTmplDesc1}": {
    stage("FIS - ${exptTmplDesc1}") {
      // Wrap in code that injects credentials so you can run kubectl
      // give jMeter a minute to generate load and for Wordpress to stablise
      sleep 60
      // Ensure any alarms linked to this fis expt. are in OK state, otherwise expt. will fail, repeat for each linked alarm
      sh """${scriptsDir}/check_cw_alarm_state.sh '${cloudwatchAlarm1}' 'OK' """
      sh """${scriptsDir}/check_cw_alarm_state.sh '${cloudwatchAlarm2}' 'OK' """

      exptTemplateId = sh ( script: """aws fis list-experiment-templates | jq -r --arg jq_expttmpldesc '${exptTmplDesc1}' '.experimentTemplates[] | select(.description == \$jq_expttmpldesc) | .id' """, returnStdout: true).trim()
      exptId = sh ( script: """aws fis start-experiment --experiment-template-id ${exptTemplateId} | jq -r '.experiment.id' """, returnStdout: true).trim()
      sh """${scriptsDir}/check_fis_expt.sh ${exptId} 5 120 """
    }
  }
  
  parallel 'Jmeter': {
    stage("Run Jmeter"){
      // Wrap in code that injects credentials so you can run kubectl
      sh """kubectl config set-context --current --namespace=${jmeterNamespace}"""
      dir ( jmeterDir ){
        // Ensure any previous tests have stopped before starting a new test
        sh """./jmeter_stop.sh"""
        sh """./start_test.sh ${jmxFile}"""
      }
    }
  }, "FIS - ${exptTmplDesc2}": {
    stage("FIS - ${exptTmplDesc2}") {
      // Wrap in code that injects credentials so you can run kubectl
      // give jMeter a minute to generate load and for Wordpress to stablise
      sleep 60
      // Ensure any alarms linked to this fis expt. are in OK state, otherwise expt. will fail, repeat for each linked alarm
      sh """${scriptsDir}/check_cw_alarm_state.sh '${cloudwatchAlarm2}' 'OK' """

      exptTemplateId = sh ( script: """aws fis list-experiment-templates | jq -r --arg jq_expttmpldesc '${exptTmplDesc2}' '.experimentTemplates[] | select(.description == \$jq_expttmpldesc) | .id' """, returnStdout: true).trim()
      exptId = sh ( script: """aws fis start-experiment --experiment-template-id ${exptTemplateId} | jq -r '.experiment.id' """, returnStdout: true).trim()
      sh """${scriptsDir}/check_fis_expt.sh ${exptId} 5 120 """
    }
  }
  
  parallel 'Jmeter': {  
    stage("Run Jmeter"){
      // Wrap in code that injects credentials so you can run kubectl
      sh """kubectl config set-context --current --namespace=${jmeterNamespace}"""
      dir ( jmeterDir ){
        // Ensure any previous tests have stopped before starting a new test
        sh """./jmeter_stop.sh"""
        sh """./start_test.sh ${jmxFile}"""
      }
    }
    }, "FIS - ${exptTmplDesc3}": {
    stage("FIS - ${exptTmplDesc3}") {
      // Wrap in code that injects credentials so you can run kubectl
      // give jMeter a minute to generate load and for Wordpress to stablise
      sleep 60
        
      // Determine RDS AZ
      rdsAZ = sh ( script: """aws rds describe-db-instances --db-instance-identifier='${rdsInstance}' | jq -r '.DBInstances[].AvailabilityZone' """, returnStdout: true).trim()
      echo "RDS primary instance is currently in ${rdsAZ}"
      
      exptTemplateId = sh ( script: """aws fis list-experiment-templates | jq -r --arg jq_expttmpldesc '${exptTmplDesc3}' '.experimentTemplates[] | select(.description == \$jq_expttmpldesc) | .id' """, returnStdout: true).trim()
      exptId = sh ( script: """aws fis start-experiment --experiment-template-id ${exptTemplateId} | jq -r '.experiment.id' """, returnStdout: true).trim()
      sh """${scriptsDir}/check_fis_expt.sh ${exptId} 5 120 """
      
      // Check canary state
      sh """${scriptsDir}/check_canary_state.sh "${canaryName}" 'PASSED' """
      echo "Success - application recovered from AZ outage within 5 minutes"
    }
  }
}
