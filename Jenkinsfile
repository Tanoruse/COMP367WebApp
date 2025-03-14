pipeline {
    agent any

    tools {
        maven "maven3"  // Use the configured Maven in Jenkins
    }

    environment {
        DOCKER_IMAGE_NAME = "tanoruse/maven-webapp" // Ensure username is lowercase
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

        stage("Prepare WAR for Docker") {
            steps {
                script {
                    if (isUnix()) {
                        sh "cp target/COMP367WebApp.war MyWebApp.war"
                    } else {
                        bat "copy target\\COMP367WebApp.war MyWebApp.war"
                    }
                }
            }
        }

        stage("Build Docker Image") {
            steps {
                script {
                    bat "docker build -t ${DOCKER_IMAGE_NAME} ."  
                }
            }
        }

        stage("Push Docker Image to Docker Hub") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PWD')]) {
                        bat "echo %DOCKERHUB_PWD% | docker login --username %DOCKERHUB_USER% --password-stdin"
                    }
                    bat "docker push ${DOCKER_IMAGE_NAME}"
                }
            }
        }

        stage("Run Docker Container") {
            steps {
                script {
                    bat "docker run -d -p 8080:8080 --name maven-webapp ${DOCKER_IMAGE_NAME}"
                }
            }
        }
    }
}
