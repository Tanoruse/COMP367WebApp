pipeline {
    agent any

    environment {
        MAVEN_VERSION = "3.8.6"
        MAVEN_HOME = "${WORKSPACE}/maven"
        PATH = "${MAVEN_HOME}/bin:${env.PATH}"
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
                git 'https://github.com/Tanoruse/COMP367WebApp.git'
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

        stage('Deploy') {
            steps {
                echo 'Deploying Application...'
            }
        }
    }
}
