pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'gitloginCred', url: 'https://github.com/Subhash-Rokkala/poultry-healthy-hens-java.git']])
            }
        }

        stage('Build WAR') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t healthy-hens:latest .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f healthy-hens || true
                docker run -d -p 2000:8080 --name healthy-hens healthy-hens:latest
                '''
            }
        }

    }
}
