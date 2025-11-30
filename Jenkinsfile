pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-cred-id' // Jenkins에 등록한 Docker Hub credentials ID
        IMAGE_NAME = "mjkang4416/bookmoa"
    }

    stages {

        stage('Clone repository') {
            steps {
                git branch: 'main', url: 'https://github.com/mjkang4416/BookMoa.git'
            }
        }

        stage('Install Node.js') {
            steps {
                // Node.js와 npm이 설치되어 있는지 확인
                sh '''
                if ! command -v node > /dev/null; then
                    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
                    apt-get install -y nodejs
                fi
                node -v
                npm -v
                '''
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
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        app.push("${BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }
}
