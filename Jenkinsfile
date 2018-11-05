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
       stage('Deploy') {
            steps {
                sh "aws ecs create-cluster --cluster-name MyCluster --region us-west-2"
            }
        }
    }
}
