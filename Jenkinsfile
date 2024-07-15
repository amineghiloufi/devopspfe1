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
        stage('Check and Set Minikube Permissions') {
            steps {
                script {
                    def keyFile = '/home/jegonise/.minikube/profiles/minikube/client.key'
                    def keyFilePermissions = sh(script: "stat -c '%A' ${keyFile}", returnStdout: true).trim()
                    
                    if (!keyFilePermissions.contains('r')) {
                        sh "sudo chmod +r ${keyFile}"
                        sh "sudo chown jenkins:jenkins ${keyFile}"
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS, variable: 'KUBECONFIG')]) {
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

