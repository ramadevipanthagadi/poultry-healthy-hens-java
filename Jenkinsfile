pipeline {
    agent any

    environment {
        IMAGE_NAME = "subhashrokkala/healthy-hens"
        TAG = "latest"
        CONTAINER_NAME = "healthy-hens"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                credentialsId: 'gitloginCred',
                url: 'https://github.com/Subhash-Rokkala/poultry-healthy-hens-java.git'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t $IMAGE_NAME:$TAG ."
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                sh '''
                echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                '''
                }
            }
        }

        stage('Push Image') {
            steps {
                sh "docker push $IMAGE_NAME:$TAG"
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f healthy-hens || true
                docker run -d -p 2000:8080 --name healthy-hens subhashrokkala/healthy-hens:latest
                '''
            }
        }
    }
}
