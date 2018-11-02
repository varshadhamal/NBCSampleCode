pipeline {
    agent any
   @Library('pipeline-build-library')_
    stages {
        stage('Build') {
            steps {
                echo 'Building.. ...'
                bat 'mvn clean install'
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }

        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
