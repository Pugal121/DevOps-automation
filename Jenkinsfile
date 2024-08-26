pipeline {
    agent any
    
    environment {
        DOCKERHUB_REPO_DEV = 'pugal121/dev_repo'
        DOCKERHUB_REPO_PROD = 'pugal121/prod_repo'
        DOCKERHUB_CREDENTIALS = credentials('1d801487-3e96-4fc0-8b12-f8482830c3eb')
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm // This checks out the code from your GitHub repository
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build Docker image
                    dockerImage = docker.build("${DOCKERHUB_REPO_DEV}:${env.BRANCH_NAME}")
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', 'DOCKERHUB_CREDENTIALS') {
                        dockerImage.push("${env.BRANCH_NAME}") // Push with branch name tag
                    }

                    // Push "latest" tag only if we're on the master branch
                    if (env.BRANCH_NAME == 'master') {
                        dockerImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the Docker container
                    // This is where you'd add commands to deploy your container
                    // Example: docker run -d -p 80:80 --name my-app ${DOCKERHUB_REPO_DEV}:${env.BRANCH_NAME}
                    echo 'Deploying the application...'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Clean up workspace, containers, images, etc., as needed
            sh 'docker rmi ${DOCKERHUB_REPO_DEV}:${env.BRANCH_NAME} || true'
        }

        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check the logs for details.'
        }
    }
}
