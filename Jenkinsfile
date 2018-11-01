def pipeline
node {
env.BUILD_DIR = "${pwd()}/buildDir_${env.BUILD_NUMBER}"
dir(env.BUILD_DIR){
	checkout scm
}
pipeline = load '${pwd()}@lbs/Pipeline.groovy'	
}	
pipeline.proceed() 
