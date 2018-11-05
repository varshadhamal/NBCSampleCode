pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo "Building.. "
                sh "mvn clean install"
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }
        stage('Test') {
            steps {
                sh "mvn test"
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }

        }
        stage('Deploy') {
            steps {
                sh "aws ecs create-cluster --cluster-name MyCluster"
            }
        }
    }
}
