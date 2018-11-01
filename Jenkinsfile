
node {
env.BUILD_DIR = "${pwd()}/buildDir_${env.BUILD_NUMBER}"
dir(env.BUILD_DIR){
	checkout scm
}
}	
def Pipeline = load 'Pipeline.groovy'
Pipeline.proceed() 
