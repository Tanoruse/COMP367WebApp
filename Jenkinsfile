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
                    bat "mvn clean package"  // Use 'bat' for Windows
                }
            }
        }
        
        stage("Build Docker Image") {
            steps {
                script {
                    bat "docker build -t anoruse/maven-webapp ."  
                }
            }
        }

        stage("Push Docker Image to Docker Hub") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        bat "echo %DOCKER_PASS% | docker login --username %DOCKER_USER% --password-stdin"
                    }
                    bat "docker push anoruse/maven-webapp"
                }
            }
        }
    }
}
