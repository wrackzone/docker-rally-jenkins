FROM jenkins
USER root
RUN apt-get update && apt-get install -y ant default-jdk && rm -rf /var/lib/apt/lists/*
USER jenkins
# COPY hpi/jenkins-ca-agile-central-build-publisher-1.0.0.hpi /usr/share/jenkins/ref/
# COPY hpi/ruby-runtime-ca-agile-central-0.0.2.hpi /usr/share/jenkins/ref/
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

