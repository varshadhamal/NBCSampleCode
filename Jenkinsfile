def pipeline
node {
env.BUILD_DIR = "${pwd()}/buildDir_${env.BUILD_NUMBER}"
dir(env.BUILD_DIR){
	checkout scm
}
pipeline = load 'Pipeline.groovy'	
}	
pipeline.proceed() 
