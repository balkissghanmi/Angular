pipeline {
  agent any
   environment {
        DOCKERHUB_USERNAME = 'balkissd'
        STAGING_TAG = "${DOCKERHUB_USERNAME}/angular:v1.0.0"
        SEMGREP_APP_TOKEN = '1c87866c63498142b962151e4b3f762e2d7b7b5985048391c299968d474708b8'
        REPORT_PATH = 'zap-reports'
        REPORT_NAME = 'report.html'
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
           //  sh "docker run -e SEMGREP_APP_TOKEN=${SEMGREP_APP_TOKEN} --rm -v \${PWD}:/src semgrep/semgrep semgrep ci "
       //sh "docker run -v ${WORKSPACE}:/src --workdir /src semgrep/semgrep --config p/ci"
        }
    }
    
    // stage('SonarQube Analysis') {
    //   steps {
    //     script {
    //     withSonarQubeEnv (installationName: 'sonarqube-scanner') {
    //       sh "/opt/sonar-scanner/bin/sonar-scanner -Dsonar.projectKey=${ANGULARKEY} -Dsonar.sources=. -Dsonar.host.url=${SONARURL} -Dsonar.login=${ANGLOGIN} "
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
    //             sh "docker run -t  owasp/zap2docker-stable zap-baseline.py -t  http://192.168.56.7:80/ || true"
    //        //     sh "docker pull ${STAGING_TAG}"
    //         //    sh "docker run --rm aquasec/trivy image --exit-code 1 --no-progress ${STAGING_TAG}"
    //         }
    //     }
    // }
    // }
//     stage('Pull Docker Image on Remote Server') {
//             steps {
//                 sshagent(['ssh-agent']) {
//                     sh ' ssh -o StrictHostKeyChecking=no vagrant@192.168.56.7 "docker run -d --name front -p 80:80 balkissd/angular:v1.0.0" '
//                 }
//             }
//         }

//  stage('OWASP ZAP Scan') {
//             steps {
//                 script {
//                     // Create report directory
//                     sh "mkdir -p ${REPORT_PATH}"
                    
//                     // Run ZAP Baseline Scan
//                     sh """
//                     docker run --rm \
//                         -v \$(pwd)/${REPORT_PATH}:/zap/wrk/:rw \
//                         owasp/zap2docker-stable zap-baseline.py \
//                         -t http://192.168.56.7:80/ \
//                         -r ${REPORT_NAME}
//                     """
//                 }
//             }
//         }
        
        // stage('Publish Report') {
        //     steps {
        //         publishHTML([
        //             allowMissing: false,
        //             alwaysLinkToLastBuild: true,
        //             keepAll: true,
        //             reportDir: "${REPORT_PATH}",
        //             reportFiles: "${REPORT_NAME}",
        //             reportName: "OWASP ZAP Security Report",
        //             reportTitles: ""
        //         ])
        //     }
        // }
    stage('Talisman Scan') {
    steps {
        script {
            // Download Talisman binary
            //sh 'curl -Ls https://github.com/thoughtworks/talisman/releases/download/v1.11.0/talisman_linux_amd64 -o talisman'
           // sh 'chmod +x talisman'

            // Run Talisman scan on the current directory
            // Adjust --pattern or other flags according to your needs
           sh '/usr/local/bin/talisman --scan ' 


            // Cleanup if you don't need the binary afterwards
            sh 'rm -f talisman'
        }
    }
}

    }
  }


