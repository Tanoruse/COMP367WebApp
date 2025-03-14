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
                    withCredentials([string(credentialsId: 'docker-hub-credentials', variable: 'DOCKER_PASSWORD')]) {
                        bat """
                        echo %DOCKER_PASSWORD% | docker login --username anoruse --password-stdin
                        docker push anoruse/webapp
                        """
                    }
                }
            }
        }
    }
}
