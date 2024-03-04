pipeline {
  agent any
   environment {
        DOCKERHUB_USERNAME = 'balkissd'
        STAGING_TAG = "${DOCKERHUB_USERNAME}/angular:v1.0.5"
        SEMGREP_APP_TOKEN = '1c87866c63498142b962151e4b3f762e2d7b7b5985048391c299968d474708b8'
        SONARQUBE_TOKEN = 'sqp_e44a882c312f996a600e5f4cf45f02e576269b9e'
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
             sh "docker run -e SEMGREP_APP_TOKEN=${SEMGREP_APP_TOKEN} --rm -v \${PWD}:/src semgrep/semgrep semgrep ci "
       //sh "docker run -v ${WORKSPACE}:/src --workdir /src semgrep/semgrep --config p/ci"
        }
    }
    //  stage('SonarQube Analysis') {
    //         steps {
    //             script {
    //                      sh 'pwd'
    //                      sh  '/opt/sonar-scanner/bin/sonar-scanner -Dsonar.projectKey=Angular -Dsonar.sources=. -Dsonar.host.url=http://192.168.56.20:9000 -Dsonar.login=sqp_e44a882c312f996a600e5f4cf45f02e576269b9e'
    //         }
    //     }
    // }
    stage('SonarQube Analysis') {
      steps {
        script {
          sh 'pwd'
          // Use the SONARQUBE_TOKEN environment variable here
          sh "/opt/sonar-scanner/bin/sonar-scanner -Dsonar.projectKey=Angular -Dsonar.sources=. -Dsonar.host.url=http://192.168.56.20:9000 -Dsonar.login=${env.SONARQUBE_TOKEN}"
        }
      }
    }
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

  }
}