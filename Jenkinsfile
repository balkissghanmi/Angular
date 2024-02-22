pipeline {
  agent any
  stages {
   stage('NPM Clean'){
        steps{
            sh 'npm cache clean --force'
             sh 'npm install --legacy-peer-deps --verbose'
             sh 'npm run build'
        }
    }
     stage('SonarQube Analysis') {
            steps {
                script {
                         sh 'pwd'
                         sh  '/opt/sonar-scanner/bin/sonar-scanner -Dsonar.projectKey=Go -Dsonar.sources=. -Dsonar.host.url=http://192.168.56.20:9000 -Dsonar.login=sqp_9847d1d46f67de8600e3ba5196e5a85b4059a3a9'
            }
        }
    }
    }
}