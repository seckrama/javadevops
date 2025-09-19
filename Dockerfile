FROM jenkins/jenkins:lts

USER root

# Installer Docker CLI et Maven
RUN apt-get update && \
    apt-get install -y maven docker.io && \
    rm -rf /var/lib/apt/lists/*

USER jenkins
