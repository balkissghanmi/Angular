pipeline {
  agent any
   environment {
        DOCKERHUB_USERNAME = 'balkissd'
        STAGING_TAG = "${DOCKERHUB_USERNAME}/angular:v1.0.0"
        SEMGREP_APP_TOKEN = '1c87866c63498142b962151e4b3f762e2d7b7b5985048391c299968d474708b8'
    }
  stages {
     stage('Checkout Git') {
            steps {
                script {
                    git branch: 'main',
                        url: 'https://github.com/balkissghanmi/Angular.git',
                        credentialsId: 'test' 
                }
            }
        }
   stage('NPM Clean'){
        steps{
            sh 'npm cache clean --force'
             sh 'npm install --legacy-peer-deps --verbose'
             sh 'npm run build'
            // sh 'ng test --no-watch --no-progress --browsers=ChromeHeadless'
             sh'pwd'
             sh "ls -la"
            // sh "npm test"
           //  sh "docker run -e SEMGREP_APP_TOKEN=${SEMGREP_APP_TOKEN} --rm -v \${PWD}:/src semgrep/semgrep semgrep ci "
       //sh "docker run -v ${WORKSPACE}:/src --workdir /src semgrep/semgrep --config p/ci"
        }
    }
    
    // stage('SonarQube Analysis') {
    //   steps {
    //     script {
    //     withSonarQubeEnv (installationName: 'sonarqube-scanner') {
    //       sh "/opt/sonar-scanner/bin/sonar-scanner "
    //     }
    //   }
    // }
    // }
    // stage('Docker'){
    //     steps {
    //         script{
    //             sh "docker build -t ${STAGING_TAG} ."
    //             withCredentials([usernamePassword(credentialsId: 'tc', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
    //             sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
    //             sh "docker push ${STAGING_TAG}"
    //         }
    //     }
    // }
    // }
    stage('Pull Docker Image on Remote Server') {
            steps {
                sshagent(['ssh-agent']) {
                    sh ' ssh -o StrictHostKeyChecking=no vagrant@192.168.56.7 "ls -a" '
                }
            }
        }
  }
}
