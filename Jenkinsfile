pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building.. ...'
                bat 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
