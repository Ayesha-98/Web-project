pipeline {
    agent any

    tools {
        jdk 'jdk21' // Ensure 'jdk21' is configured in Jenkins Global Tool Configuration
    }

    environment {
        DOCKER_IMAGE = 'ayesha980/app' // Replace with your Docker Hub username/repository
    }

    stages {
        // Stage 1: Checkout Code from GitHub
        stage('Git Checkout') {
            steps {
                git changelog: false, poll: false, url: 'https://github.com/Ayesha-98/Web-project.git'
            }
        }
        
        // Stage 2: Install Dependencies
        stage('Build') {
            steps {
                script {
                    bat 'npm install' // Installs dependencies defined in package.json
                }
            }
        }
        
        // Stage 3: Build and Push Docker Image
        stage('Docker Build & Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '241a9dc2-d77a-4fa0-bd4c-5c9b3568671b') {
                        if (isUnix()) {
                            sh '''
                            docker build -t ${DOCKER_IMAGE}:latest .
                            docker push ${DOCKER_IMAGE}:latest
                            '''
                        } else {
                            bat '''
                            docker build -t ${DOCKER_IMAGE}:latest .
                            docker push ${DOCKER_IMAGE}:latest
                            '''
                        }
                    }
                }
            }
        }

        // Stage 4: Deploy Docker Container
        stage('Docker Container') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '241a9dc2-d77a-4fa0-bd4c-5c9b3568671b') {
                        if (isUnix()) {
                            sh '''
                            # Stop and remove existing container (if it exists)
                            if [ $(docker ps -aq -f name=app) ]; then
                                docker rm -f app
                            fi
                            # Run new container
                            docker run -d --name app -p 8081:5000 ${DOCKER_IMAGE}:latest
                            '''
                        } else {
                            bat '''
                            @echo off
                            for /f "tokens=*" %%i in ('docker ps -aq -f "name=app"') do docker rm -f %%i
                            docker run -d --name app -p 8081:5000 ${DOCKER_IMAGE}:latest
                            '''
                        }
                    }
                }
            }
        }
    }
}
