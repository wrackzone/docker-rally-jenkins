FROM jenkins
USER root
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

