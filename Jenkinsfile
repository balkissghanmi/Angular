pipeline {
  agent any
  stages {
   stage('NPM Clean'){
        steps{
            sh 'npm cache clean --force'
             sh 'npm install '
             sh 'npm run build'
        }
    }
    }
}