#! /bin/bash

# Parse a support-core plugin -style txt file as specification for jenkins plugins to be installed
# in the reference directory, so user can define a derived Docker image with just :
#
# FROM jenkins
# COPY plugins.txt /plugins.txt
# RUN /usr/local/bin/plugins.sh /plugins.txt
#

# set -e

REF=/usr/share/jenkins/ref/plugins
mkdir -p $REF
curl -sSL https://github.com/wrackzone/docker-rally-jenkins/raw/master/hpi/ruby-runtime-ca-agile-central-0.0.2.hpi -o $REF/ruby-runtime-ca-agile-central-0.0.2.hpi
curl -sSL https://github.com/wrackzone/docker-rally-jenkins/raw/master/hpi/jenkins-ca-agile-central-build-publisher-1.0.0.hpi -o $REF/jenkins-ca-agile-central-build-publisher-1.0.0.hpi

echo "installing plugins"

while read spec || [ -n "$spec" ]; do

    plugin=(${spec//:/ });
    [[ ${plugin[0]} =~ ^# ]] && continue
    [[ ${plugin[0]} =~ ^\s*$ ]] && continue
    [[ -z ${plugin[1]} ]] && plugin[1]="latest"
    echo "Downloading ${plugin[0]}:${plugin[1]}"

    if [ -z "$JENKINS_UC_DOWNLOAD" ]; then
      JENKINS_UC_DOWNLOAD=$JENKINS_UC/download
    fi
    curl -sSL -f ${JENKINS_UC_DOWNLOAD}/plugins/${plugin[0]}/${plugin[1]}/${plugin[0]}.hpi -o $REF/${plugin[0]}.jpi
    unzip -qqt $REF/${plugin[0]}.jpi
    
done  < $1

#curl -sSl -f https://help.rallydev.com/sites/default/files/multimedia/jenkins-ca-agile-central-build-publisher-4.0.0.zip -o $REF/jenkins-ca-agile-central-build-publisher-4.0.0.zip
#unzip -qqt $REF/jenkins-ca-agile-central-build-publisher-4.0.0.zip


