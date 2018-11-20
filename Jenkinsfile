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
                sh "docker build -t 892943703739.dkr.ecr.us-west-2.amazonaws.com/varshaapachetomcat:latest ."
                sh "eval \$(aws ecr get-login --no-include-email  --region us-west-2)"
                sh "docker push 892943703739.dkr.ecr.us-west-2.amazonaws.com/varshaapachetomcat:latest"
                
            }
        }
      stage('Deploy') {
          steps {
                   sh "aws ecs list-container-instances --cluster default --region us-west-2"
                   sh "aws ecs describe-container-instances --cluster default --container-instances 8d1208ca-53ab-4e76-8ceb-e4a1c637b179 --region us-west-2"
                   sh "aws ecs list-task-definitions"        
          }
        }
    }
}
