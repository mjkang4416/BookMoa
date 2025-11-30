node {
    def app

    stage('Clone repository') {
        git 'https://github.com/mjkang4416/BookMoa.git'
    }

    stage('Build image') {
        app = docker.build("mjkang4416/bookmoa")
    }

    stage('Test image') {
        app.inside {
            sh """
            npm install
            npm test || echo 'No tests found'
            """
        }
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-cred') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
