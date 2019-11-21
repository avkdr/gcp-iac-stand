#!/bin/bash

sudo yum install -y java-1.8.0-openjdk-devel
sudo yum update
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install -y jenkins
yum install -y git
yum install -y ansible
sudo yum install -y wget
echo 'Downloading Maven'
sudo yum install -y maven
#wget https://www-us.apache.org/dist/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz -P /tmp
#wget https://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -P /tmp
#echo 'Extracting Maven'
#sudo tar xf /tmp/apache-maven-3.6.2-bin.tar.gz -C /opt
#sudo ln -s /opt/apache-maven-3.6.2 /opt/maven
#sudo echo -e 'export JAVA_HOME=/usr/lib/jvm/jre-openjdk export M2_HOME=/opt/maven export MAVEN_HOME=/opt/maven export PATH=${M2_HOME}/bin:${PATH}' > /etc/profile.d/maven.sh
#sudo chmod +x /etc/profile.d/maven.sh
#source /etc/profile.d/maven.sh

USERNAME="${1}"
SSH_KEY=$(cat /tmp/id_rsa.pub)

adduser "${USERNAME}"
usermod -aG 'wheel' "${USERNAME}"

mkdir "/home/${USERNAME}/.ssh"
chown "${USERNAME}":"${USERNAME}" "/home/${USERNAME}/.ssh"
echo "${SSH_KEY}" | tee "/home/${USERNAME}/.ssh/authorized_keys"

chmod 600 "/home/${USERNAME}/.ssh/authorized_keys"
chown "${USERNAME}":"${USERNAME}" "/home/${USERNAME}/.ssh/authorized_keys"
