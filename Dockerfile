FROM jenkins/jenkins:lts

# Passer en root pour installer Maven
USER root

RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

# Revenir à l'utilisateur Jenkins
USER jenkins
