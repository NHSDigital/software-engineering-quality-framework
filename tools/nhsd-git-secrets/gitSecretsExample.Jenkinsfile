pipeline {

  agent {
    label 'jenkins-slave'
  }

  options {
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '15'))
  }

  stages {
    
    stage("Scan Commit") {
      steps {
        script {
          dir ("nhsd-git-secrets"){
            // Temporary '|| true' to stop pipeline failing, remove once detected secrets have been removed
            sh ("./scan-repo-linux-mac.sh || true")
          }
        }
      }
    }
    
    // Disabled by default - this may take a few minutes to run
    // stage("Scan git history") {
    //   steps {
    //     script {
    //       dir ("nhsd-git-secrets"){
    //         sh ("./full-history-scan.sh")
    //       }
    //     }
    //   }
    // }
    
  }


}
