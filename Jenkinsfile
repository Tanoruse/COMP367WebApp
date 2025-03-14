pipeline {
    agent any

    tools {
        maven "maven3"  
    }

    stages {
        stage("Check out") {
            steps {
                git branch: 'master', url: 'https://github.com/Tanoruse/COMP367WebApp'
            }
        }

        stage("Build Maven") {
            steps {
                script {
                    bat "mvn clean package"
                }
            }
        }
        
        stage("Build Docker image") {
            steps {
                script {
                    bat "docker build -t anoruse/webapp ."  
                }
            }
        }

        stage("Push Docker image to Docker Hub") {
            steps {
                script {
                    bat "echo passwordd | docker login --username anoruse --password-stdin"
                    bat "docker push anoruse/webapp"
                }
            }
        }
    }
}
