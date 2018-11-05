pipeline {
    agent any
    tools {
        maven 'mvn'
        docker 'docker' 
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
                sh "docker build -t 892943703739.dkr.ecr.us-west-2.amazonaws.com/varshaapachetomcat:latest ."
                sh "docker push 892943703739.dkr.ecr.us-west-2.amazonaws.com/varshaapachetomcat:latest"
            }
        }
       stage('Deploy') {
            steps {
               // sh "aws ecs create-cluster --cluster-name MyCluster --region us-west-2"
                  sh "aws ecs list-container-instances"
                  
            }
        }
    }
}
