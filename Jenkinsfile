def pipeline = load 'Pipeline.groovy'
node {
env.BUILD_DIR = "${pwd()}/buildDir_${env.BUILD_NUMBER}"
dir(env.BUILD_DIR){
	checkout scm
}
}	
pipeline.proceed() 
