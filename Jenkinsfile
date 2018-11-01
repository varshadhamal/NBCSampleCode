node {
env.BUILD_DIR = "${pwd()}/buildDir_${env.BUILD_NUMBER}"
dir(env.BUILD_DIR){
	checkout scm
}
}	
def Pipeline1 = load 'Pipeline.groovy'
Pipeline1.proceed() 
