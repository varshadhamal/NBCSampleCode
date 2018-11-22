
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
                script {
                echo "Building.. "
                echo "branch: ${env.BRANCH_NAME}"
                sh "mvn clean install -DskipTests"
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
                sh "docker build -t 892943703739.dkr.ecr.us-west-2.amazonaws.com/varshaapachetomcat:latest ."
                sh "eval \$(aws ecr get-login --no-include-email  --region us-west-2)"
                //sh "docker push 892943703739.dkr.ecr.us-west-2.amazonaws.com/varshaapachetomcat:latest"
                def DockerImageconfigFileId = 'nbcsampleconfig'    
                configFileProvider([configFile(fileId: DockerImageconfigFileId, variable: 'DOCKERIMAGE')]) { 
                    def value = readJSON file: env.DOCKERIMAGE
                    def dockerImage = value.dockerImage
                    def dockerImageTag = value.dockerImageTag
                    sh "docker push ${dockerImage}:${dockerImageTag}"
                }
               }
            }
        }
        
       stage ('deploy development')
        {
            when {
            expression {
               // GIT_BRANCH = 'origin/' + sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                GIT_BRANCH = env.BRANCH_NAME
                return (GIT_BRANCH == 'develop')
                       }
                 }
            steps
                {
                    sh "aws ecs register-task-definition --cli-input-json file://sample.json --region us-west-2"
                    sh "aws ecs create-service --cluster devenv --service-name nbcsampleservice --task-definition sleep360:5 --desired-count 10 --region us-west-2"
                    sh "aws ecs update-service --cluster devenv --service nbcsampleservice --task-definition sleep360:5 --desired-count 10 --region us-west-2"
                }
        
        }
        
       stage ('deploy master')
        {
            when {
            expression {
               // GIT_BRANCH = 'origin/' + sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                GIT_BRANCH = env.BRANCH_NAME
                return (GIT_BRANCH == 'master')
                       }
                 }
            steps
                {
                    sh "aws ecs register-task-definition --cli-input-json file://sample.json --region us-west-2"
                    sh "aws ecs update-service --cluster default --service nbcsampleservice --task-definition sleep360:5 --desired-count 10 --region us-west-2"
                }
        
        }

    }
}
