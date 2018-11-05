pipeline {
    agent any
    tools {
        maven 'mvn'
    }
    stages {
      stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }
        stage('Build') {
            steps {
                echo "Building.. "
                sh "mvn clean install -DskipTests"
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
