pipeline {
    agent any

    environment {
        NODEJS_HOME = tool name: 'NodeJS 16', type: 'NodeJSInstallation'
        PATH = "${env.NODEJS_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/GhiloufiAmine/PFE.git'
            }
        }
        stage('Build Angular') {
            steps {
                dir('frontend') {
                    sh 'npm install'
                    sh 'ng build --prod'
                }
            }
        }
        stage('Build Spring Boot') {
            steps {
                dir('backend') {
                    sh './mvnw clean package'
                }
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t jegoniseghiloufi/pfe .'
            }
        }
        stage('Docker Push') {
            steps {
                withDockerRegistry([ credentialsId: 'jegodocker', url: 'https://index.docker.io/v1/' ]) {
                    sh 'docker push jegoniseghiloufi/pfe'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'jegokube']) {
                    sh 'kubectl apply -f k8s/deployment.yaml'
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

