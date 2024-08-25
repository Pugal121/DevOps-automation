pipeline {
    agent any
    
    environment {
        DOCKER_DEV_REPO = 'pugal121/dev_repo'
        DOCKER_PROD_REPO = 'pugal121/prod_repo'
        DOCKER_CREDENTIALS_ID = '1d801487-3e96-4fc0-8b12-f8482830c3eb'
    }
    
   stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def branch = env.GIT_BRANCH
                    echo "Building Docker image for branch ${branch}"
                    if (branch == "origin/dev") {
                        docker.build("${DOCKER_DEV_REPO}:latest")
                    } else if (branch == "origin/master") {
                        docker.build("${DOCKER_PROD_REPO}:latest")
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    def branch = env.GIT_BRANCH
                    echo "Pushing Docker image for branch ${branch}"
                    if (branch == "origin/dev") {
                        docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                            docker.image("${DOCKER_DEV_REPO}:latest").push()
                        }
                    } else if (branch == "origin/master") {
                        docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                            docker.image("${DOCKER_PROD_REPO}:latest").push()
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Build and push completed successfully."
        }
        failure {
            echo "Build or push failed."
        }
    }
}
