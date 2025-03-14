pipeline {
    agent any

    tools {
        maven "Maven"  
    }

    stages {
        stage("Check out") {
            steps {
                git branch: 'master', url: 'https://github.com/Tanoruse/COMP367WebApp.git'
            }
        }

        stage("Build Maven") {
            steps {
                script {
                    bat "mvn clean package"  // Use 'bat' for Windows
                }
            }
        }
        
        stage("Build Docker image") {
            steps {
                script {
                    bat "docker build -t tanoruse/maven-webapp ."  
                }
            }
        }

        stage("Push Docker image to Docker Hub") {
            steps {
                script {
                    withCredentials([string(credentialsId: 'docker-hub-credentials', variable: 'DOCKERHUB_PWD')]) {
                        bat "echo %DOCKERHUB_PWD% | docker login --username tanoruse --password-stdin"
                    }
                    bat "docker push tanoruse/maven-webapp"
                }
            }
        }
    }
}
