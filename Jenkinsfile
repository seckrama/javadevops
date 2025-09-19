pipeline {
    agent any

    environment {
        IMAGE_NAME = "seckrama/mon-app" // Remplace par ton nom d'utilisateur Docker Hub
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

        stage('Docker Login & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                        docker push ${IMAGE_NAME}:latest
                        docker logout
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline terminée avec succès ! L'image Docker a été poussée."
        }
        failure {
            echo "La pipeline a échoué. Vérifie les logs pour les erreurs."
        }
    }
}
