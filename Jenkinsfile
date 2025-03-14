pipeline {
    agent any

    tools {
        maven 'maven3' // Use Maven configured in Jenkins
    }

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        DOCKER_IMAGE_NAME = "tanoruse/maven-webapp" // Ensure username is lowercase
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

        stage('Prepare Docker Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh "cp target/COMP367WebApp.war ."
                    } else {
                        bat "copy target\\COMP367WebApp.war ."
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
                        bat """
                        echo %DOCKER_HUB_CREDENTIALS_PSW% | docker login -u %DOCKER_HUB_CREDENTIALS_USR% --password-stdin
                        """
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh "docker build -t ${DOCKER_IMAGE_NAME}:latest -f Dockerfile ."
                    } else {
                        bat "docker build -t %DOCKER_IMAGE_NAME%:latest -f Dockerfile ."
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
                        sh "docker run -d -p 9090:9090 --
