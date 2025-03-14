pipeline {
    agent any

    tools {
        maven 'maven3' // Use Maven configured in Jenkins
    }

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        DOCKER_IMAGE_NAME = "Tanoruse/maven-webapp"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Tanoruse/COMP367WebApp.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'mvn clean package'
                    } else {
                        bat 'mvn clean package'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'mvn test'
                    } else {
                        bat 'mvn test'
                    }
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin'
                    } else {
                        bat "echo %DOCKER_HUB_CREDENTIALS_PSW% | docker login -u %DOCKER_HUB_CREDENTIALS_USR% --password-stdin"
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh "docker build -t ${DOCKER_IMAGE_NAME}:latest ."
                    } else {
                        bat "docker build -t %DOCKER_IMAGE_NAME%:latest ."
                    }
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    if (isUnix()) {
                        sh "docker push ${DOCKER_IMAGE_NAME}:latest"
                    } else {
                        bat "docker push %DOCKER_IMAGE_NAME%:latest"
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    if (isUnix()) {
                        sh "docker run -d -p 9090:9090 --name maven-webapp ${DOCKER_IMAGE_NAME}:latest"
                    } else {
                        bat "docker run -d -p 9090:9090 --name maven-webapp %DOCKER_IMAGE_NAME%:latest"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deployment Completed Successfully!'
            }
        }
    }
}
