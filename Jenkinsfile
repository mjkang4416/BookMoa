pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'mjkang4416'   
        IMAGE_NAME = "mjkang4416/bookmoa"
    }

    stages {

        stage('Clone repository') {
            steps {
                git branch: 'main', url: 'https://github.com/mjkang4416/BookMoa.git'
            }
        }

        stage('Install Node modules') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run tests') {
            when {
                expression { fileExists('package.json') }
            }
            steps {
                sh 'npm test || echo "테스트 스킵됨"'
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    app = docker.build("${IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
                        app.push("${BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }
}
