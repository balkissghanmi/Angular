pipeline {
    agent any
    environment {
       // CHROME_BIN='/usr/bin/chromium'
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
                //sh' npx karma start karma.conf.js --single-run'
                //sh 'npm install karma karma-jasmine jasmine-core karma-chrome-launcher --save-dev'
                //sh 'npm test'
            }
        }
        //  stage('Run Tests') {
        //     steps {
        //         sh'npm install --save-dev jest-junit'
        //         sh 'npm test -- --coverage --ci'
        //          junit 'coverage/jest-junit.xml'
        //     }
        // }
        // stage('Dependencies Test with SNYK') {
        //     steps {
        //         snykSecurity(
        //             snykInstallation: 'snyk@latest',
        //             snykTokenId: 'snyk-token',
        //             failOnIssues: 'false',
        //             monitorProjectOnBuild: 'true',
        //             additionalArguments: '--all-projects --d'
        //         )
        //     }
        // }
        // stage('Analysis with SEMGREP ') {
        //     steps {
        //         //sh "docker run -v ${WORKSPACE}:/src --workdir /src semgrep/semgrep --config p/ci"
        //          sh "docker run -e SEMGREP_APP_TOKEN=${SEMGREP_APP_TOKEN} --rm -v \${PWD}:/src semgrep/semgrep semgrep ci "
        //     }
        // }
        // stage('Analysis with SONARQUBE ') {
        //     steps {
        //         script {
        //             withSonarQubeEnv (installationName: 'sonarqube-scanner') {
        //                 sh "/opt/sonar-scanner/bin/sonar-scanner -Dsonar.projectKey=${ANGULARKEY} -Dsonar.sources=. -Dsonar.host.url=${SONARURL} -Dsonar.login=${ANGLOGIN}"
        //             }
        //         }
        //     }
        // }
        // stage('Containerization with DOCKER'){
        //     steps {
        //         script {
        //             sh "docker build -t ${STAGING_TAG} ."
        //             withCredentials([usernamePassword(credentialsId: 'tc', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
        //                 sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
        //                 sh "docker push ${STAGING_TAG}"
        //                // sh "docker pull ${STAGING_TAG}"
        //             }
        //         }
        //     }
        // }
        // stage('Image Test with TRIVY') {
        //     steps {
        //         sh "docker run --rm aquasec/trivy image --exit-code 1 --no-progress  ${STAGING_TAG}"
        //         //sh "docker run --rm aquasec/trivy:latest image balkissd/angular:v1.0.0"
 
        //     }
        // }
        // stage('Pull Docker Image on Remote Server') {
        //     steps {
        //         sshagent(['ssh-agent']) {
        //             sh ' ssh -o StrictHostKeyChecking=no vagrant@192.168.56.7 "docker run -d --name front -p 80:80 balkissd/angular:v1.0.0"'
        //         }
        //     }
        // }
        // stage('Container Test with SNYK') {
        //     steps {
        //         snykSecurity(
        //             snykInstallation: 'snyk@latest',
        //             snykTokenId: 'snyk-token',
        //             failOnIssues: 'false',
        //             monitorProjectOnBuild: 'true',
        //             additionalArguments: '--container ${STAGING_TAG} -d' 
        //         )
        //     }
        // }
       
        // stage('OWASP ZAP Test') {
        //     steps {
        //         sh "docker run -t  owasp/zap2docker-stable zap-baseline.py -t  http://192.168.56.7:80/ || true"
        //     }
        // }
stage('Initialization') {
            steps {
                script {
                    parameters {
                        choice choices: ['Baseline', 'APIS', 'Full'],
                                description: 'Type of scan that is going to perform inside the container',
                                name: 'SCAN_TYPE'

                        string defaultValue: 'http://192.168.56.7:80',
                                description: 'Target URL to scan',
                                name: 'TARGET'

                        booleanParam defaultValue: true,
                                description: 'Parameter to know if you want to generate a report.',
                                name: 'GENERATE_REPORT'
                    }
                }
            }
        }
        stage('Setting up OWASP ZAP Docker Container') {
            steps {
                sh 'docker pull owasp/zap2docker-stable:latest'
                sh 'docker run -dt --name owasp owasp/zap2docker-stable /bin/bash'
            }
        }
        stage('Preparing the Working Directory') {
            when {
                expression {
                    params.GENERATE_REPORT
                }
            }
            steps {
                sh 'docker exec owasp mkdir /zap/wrk'
            }
        }
        stage('Scanning the Target on the OWASP Container') {
            steps {
                script {
                    scan_type = "${params.SCAN_TYPE}"
                    target = "${params.TARGET}"
                    if (scan_type == 'Baseline') {
                        sh """
                            docker exec owasp \
                            zap-baseline.py \
                            -t $target \
                            -r report.html \
                            -I
                        """
                    } else if (scan_type == 'APIS') {
                        sh """
                            docker exec owasp \
                            zap-api-scan.py \
                            -t $target \
                            -r report.html \
                            -I
                        """
                    } else if (scan_type == 'Full') {
                        sh """
                            docker exec owasp \
                            zap-full-scan.py \
                            -t $target \
                            -r report.html \
                            -I
                        """
                    } else {
                        echo 'Something went wrong...'
                    }
                }
            }
        }
        stage('Copying the Report to Workspace') {
            steps {
                script {
                    sh '''
                        docker cp owasp:/zap/wrk/report.html ${WORKSPACE}/report.html
                    '''
                }
            }
        }

   
    }
}
