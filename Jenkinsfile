
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
       stage('Build all branches') {          
            steps {
                script {
                         sh "mvn clean install -DskipTests"
               		// archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
               // sh "docker build -t 892943703739.dkr.ecr.us-west-2.amazonaws.com/varshaapachetomcat:latest ."
                //sh "docker push 892943703739.dkr.ecr.us-west-2.amazonaws.com/varshaapachetomcat:latest"
	              }
                 }
        }
       stage ('test')
        {
            steps{
            sh "mvn test"
            }
        }
       stage ('push docker image')
	    {
             when {
              expression {
               // GIT_BRANCH = 'origin/' + sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                GIT_BRANCH = env.BRANCH_NAME
                return (GIT_BRANCH == 'develop' || GIT_BRANCH == 'master')
                       }
                 }
	     steps
		    { 
			script {
			    sh "eval \$(aws ecr get-login --no-include-email  --region us-west-2)"
                		def DockerImageconfigFileId = 'nbcsampleconfig'    
                		configFileProvider([configFile(fileId: DockerImageconfigFileId, variable: 'DOCKERIMAGE')]) { 
                    			def value = readJSON file: env.DOCKERIMAGE
                    			def dockerImage = value.dockerImage
                    			def dockerImageTag = value.dockerImageTag
                    		sh "docker build -t ${dockerImage}:${dockerImageTag} ."
                    		sh "docker push ${dockerImage}:${dockerImageTag}"
				}
               
		    }
	    }
	    }
       stage ('Publish artifact')
	    {
		    when {
             		 expression {
               				// GIT_BRANCH = 'origin/' + sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                			GIT_BRANCH = env.BRANCH_NAME
                			return ( GIT_BRANCH == 'master')
                       		    }
                 	}
		    steps {
		    	 script {
             		 	  def pom = readMavenPom file: 'pom.xml'
                		  echo pom.version
			          dir(env.BUILD_DIR/target)
				 {
				  nexusArtifactUploader(
    					nexusVersion: 'nexus3',
	    				protocol: 'http',
    					nexusUrl: 'http://34.208.184.67:8081/nexus',
    					groupId: 'com.jcg.maven',
    					version: pom.version,
					repository: 'Samplerepo',
   					credentialsId: 'b19ea1d1-f9b5-48df-99df-0a04ceac429b',
    					artifacts: [
        					[artifactId: pom.artifactId,
         					 classifier: '',
        					 file: pom.name + '-' + pom.version + '.jar',
       						 type: 'jar']
    						   ])
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
                    script {
	                def DockerImageconfigFileId = 'nbcsampleconfig' 
	                configFileProvider([configFile(fileId: DockerImageconfigFileId, variable: 'DOCKERIMAGE')]) { 
                    def value = readJSON file: env.DOCKERIMAGE
					def region = value.region
					def service = value.service
                    def devenv = value.devenv    
                    //sh "aws ecs register-task-definition --cli-input-json file://sample.json --region ${region}"
		    //sh "aws ecs run-task --cluster ${devenv} --task-definition sleep360:1 --count 1 --region ${region}"		
                    sh "aws ecs update-service --cluster ${devenv} --service ${service} --task-definition sleep360:1 --desired-count 1 --region ${region}"
                    }
                    }
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
                    script {
	                def DockerImageconfigFileId = 'nbcsampleconfig' 
	                configFileProvider([configFile(fileId: DockerImageconfigFileId, variable: 'DOCKERIMAGE')]) { 
                    def value = readJSON file: env.DOCKERIMAGE
					def region = value.region
					def service = value.service
                    def prodenv = value.prodenv    
                    sh "aws ecs register-task-definition --cli-input-json file://sample.json --region ${region}"
		    sh "aws ecs run-task --cluster ${prodenv} --task-definition hello-world:1 --count 1 --region ${region}"		
                    //sh "aws ecs create-service --cluster default --service-name nbcsampleservice --task-definition hello-world:1 --desired-count 1 --region us-west-2"
		    sh "aws ecs update-service --cluster ${prodenv} --service ${service} --task-definition hello-world:1 --desired-count 1 --region ${region}"
                    }
                    }
                }    
        
        }
      //stage('Deploy') {
        //      steps {
                         
                 //  sh "aws ecs list-container-instances --cluster default --region us-west-2"
                 //  sh "aws ecs describe-container-instances --cluster default --container-instances 8d1208ca-53ab-4e76-8ceb-e4a1c637b179 --region us-west-2"
                  // sh "aws ecs register-task-definition --cli-input-json file://sample.json --region us-west-2"
                 //  sh "aws ecs list-task-definitions --region us-west-2"
                   
                 //  sh "aws ecs list-tasks --cluster default --region us-west-2" 
                  // sh "aws ecs describe-tasks --cluster default --task 4831f0e4-c76b-45aa-8a96-952c4341d749 --region us-west-2" 
                   //sh "aws ecs create-service --cluster default --service-name nbcsampleservice --task-definition sleep360:5 --desired-count 10 --region us-west-2"
                   //   script {
                     //             if (env.BRANCH_NAME == 'master') {
                       //                sh "aws ecs run-task --cluster default --task-definition sleep360:1 --count 1 --region us-west-2"   
                         //              sh "aws ecs update-service --cluster default --service nbcsampleservice --task-definition sleep360:5 --desired-count 10 --region us-west-2"
                          //         } else {
                          //             sh "aws ecs run-task --cluster devenv --task-definition sleep360:1 --count 1 --region us-west-2"
                          //             sh "aws ecs update-service --cluster devenv --service nbcsampleservice --task-definition sleep360:5 --desired-count 10 --region us-west-2"
                          //        }
                          
                  
                 //     }
         // }
        // }
    }
}
