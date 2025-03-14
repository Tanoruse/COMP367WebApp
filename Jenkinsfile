pipeline {
    agent any

    environment {
        MAVEN_VERSION = "3.8.6"
        MAVEN_HOME = "${WORKSPACE}/maven"
        PATH = "${MAVEN_HOME}/bin:${env.PATH}"
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        DOCKER_IMAGE_NAME = "Tanoruse/maven-webapp"
    }

    stages {
        stage('Setup Maven') {
            steps {
                script {
                    if (isUnix()) {
                        sh '''
                            wget https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
                            tar -xvzf apache-maven-${MAVEN_VERSION}-bin.tar.gz
                            mv apache-maven-${MAVEN_VERSION} ${MAVEN_HOME}
                        '''
                    } else {
                        bat '''
                            curl -o maven.zip https://downloads.apache.org/maven/maven-3/%MAVEN_VERSION%/binaries/apache-maven-%MAVEN_VERSION%-bin.zip
                            powershell -Command "Expand-Archive -Path maven.zip -DestinationPath ."
                            move apache-maven-%MAVEN_VERSION% maven
                        '''
                    }
                }
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Tanoruse/COMP367WebApp.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh '${MAVEN_HOME}/bin/mvn clean package'
                    } else {
                        bat '%MAVEN_HOME%\\bin\\mvn clean package'
                    }
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    if (isUnix()) {
                        sh '${MAVEN_HOME}/bin/mvn test'
                    } else {
                        bat '%MAVEN_HOME%\\bin\\mvn test'
                    }
                }
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    sh 'echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin'
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    sh "docker push ${DOCKER_IMAGE_NAME}:latest"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -d -p 9090:9090 --name maven-webapp ${DOCKER_IMAGE_NAME}:latest"
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
