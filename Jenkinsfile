pipeline {
    agent any

    environment {
        // Credentials Docker Hub
        DOCKER_CREDENTIALS = credentials('docker-hub')  
        DOCKER_USER = "${DOCKER_CREDENTIALS_USR}"
        DOCKER_PASS = "${DOCKER_CREDENTIALS_PSW}"
        
        // Nom de l'image Docker
        IMAGE_NAME = "ton-nom-utilisateur-docker/mon-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git(
                    branch: 'main',
                    url: 'https://github.com/seckrama/java-devops.git',
                    credentialsId: 'github-credentials'
                )
            }
        }

        stage('Build Maven') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Docker Push') {
            steps {
                sh "docker push ${IMAGE_NAME}:latest"
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
        success {
            echo "Pipeline terminé avec succès et l'image Docker a été poussée !"
        }
        failure {
            echo "La pipeline a échoué. Vérifie les logs."
        }
    }
}
