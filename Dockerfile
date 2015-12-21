FROM jenkins
USER root
RUN apt-get update && apt-get install -y ant default-jdk && rm -rf /var/lib/apt/lists/*
USER jenkins
COPY hpi/ /usr/share/jenkins/ref/plugins
COPY hpi/ /usr/share/jenkins/ref/plugins
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

