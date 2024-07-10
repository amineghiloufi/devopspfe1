pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = 'jegodocker'
        KUBECONFIG_CREDENTIALS = 'jegokube'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/amineghiloufi/pfe.git'
            }
        }
        stage('Build and Package') {
            steps {
                script {
                    sh 'docker build -t jegoniseghiloufi/pfe:latest .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        sh 'docker push jegoniseghiloufi/pfe:latest'
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: KUBECONFIG_CREDENTIALS]) {
                        sh 'kubectl apply -f k8s/deployment.yaml'
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}

