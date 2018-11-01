@Library('pipeline-build-library')
node {
env.BUILD_DIR = "${pwd()}/buildDir_${env.BUILD_NUMBER}"
dir(env.BUILD_DIR){
	checkout scm
}
}
Pipeline.proceed() 
