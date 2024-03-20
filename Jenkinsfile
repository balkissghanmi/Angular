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
        stage('NPM Build'){
            steps {
                sh 'npm cache clean --force'
                sh 'npm install --legacy-peer-deps --verbose'
                sh 'npm run build'
                // sh 'ng test --no-watch --no-progress --browsers=ChromeHeadless'
            }
        }
        stage('Dependencies Test with SNYK') {
            steps {
                snykSecurity(
                    snykInstallation: 'snyk@latest',
                    snykTokenId: 'snyk-token',
                    failOnIssues: 'false',
                    monitorProjectOnBuild: 'true',
                    additionalArguments: '--all-projects --d'
                )
            }
        }
        stage('Container Test with SNYK') {
            steps {
                snykSecurity(
                    snykInstallation: 'snyk@latest',
                    snykTokenId: 'snyk-token',
                    failOnIssues: 'false',
                    monitorProjectOnBuild: 'true',
                    additionalArguments: '--container ${STAGING_TAG} -d'
                )
            }
        }
        stage('Analysis with SEMGREP ') {
            steps {
                sh "docker run -v ${WORKSPACE}:/src --workdir /src semgrep/semgrep --config p/ci"
            }
        }
        stage('Analysis with SONARQUBE ') {
            steps {
                script {
                    withSonarQubeEnv (installationName: 'sonarqube-scanner') {
                        sh "/opt/sonar-scanner/bin/sonar-scanner -Dsonar.projectKey=${ANGULARKEY} -Dsonar.sources=. -Dsonar.host.url=${SONARURL} -Dsonar.login=${ANGLOGIN}"
                    }
                }
            }
        }
        stage('Containerization with DOCKER'){
            steps {
                script {
                    sh "docker build -t ${STAGING_TAG} ."
                    withCredentials([usernamePassword(credentialsId: 'tc', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
                        sh "docker push ${STAGING_TAG}"
                       // sh "docker pull ${STAGING_TAG}"
                    }
                }
            }
        }
        stage('Image Test with TRIVY') {
            steps {
                sh "docker run --rm aquasec/trivy image --exit-code 1 --no-progress ${STAGING_TAG}"
            }
        }
        stage('Pull Docker Image on Remote Server') {
            steps {
                sshagent(['ssh-agent']) {
                    sh ' ssh -o StrictHostKeyChecking=no vagrant@192.168.56.7 "docker run -d --name front -p 80:80 balkissd/angular:v1.0.0"'
                }
            }
        }
        stage('Container Test with SNYK') {
            steps {
                snykSecurity(
                    snykInstallation: 'snyk@latest',
                    snykTokenId: 'snyk-token',
                    failOnIssues: 'false',
                    monitorProjectOnBuild: 'true',
                    additionalArguments: '--container ${STAGING_TAG} -d' 
                )
            }
        }
        stage('OWASP ZAP Test') {
            steps {
                sh "docker run -t  owasp/zap2docker-stable zap-baseline.py -t  http://192.168.56.7:80/ || true"
            }
        }
    }
}
