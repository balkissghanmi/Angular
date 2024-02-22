pipeline {
  agent any
   stage('NPM Clean'){
        steps{
            sh 'npm cache clean --force'
            sh 'rm -rf node_modules package-lock.json'
        }
    }
}