pipeline {
    agent any

    environment {
        IMAGE_NAME = "banking-app"
        IMAGE_TAG = "latest"
        APP_PORT = "8081" // EC2 host port for your app
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning GitHub repo"
                git branch: 'main', url: 'https://github.com/Lohithlohi1999/devops-demo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image from project"
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo "Running the Docker container"
                // Remove old container if exists
                sh 'docker rm -f $IMAGE_NAME || true'
                // Run container mapping host port 8081 to container 8080
                sh 'docker run -d --name $IMAGE_NAME -p $APP_PORT:8080 $IMAGE_NAME:$IMAGE_TAG'
            }
        }
    }

    post {
        always {
            echo "CI Pipeline finished"
        }
    }
}

