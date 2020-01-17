#!/bin/bash

echo 'Installing JDK'
sudo yum install -y java-1.8.0-openjdk-devel
sudo yum update -y

echo 'Installing jenkins'
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install -y jenkins

echo 'Installing git'
yum install -y git

echo 'Installing ansible'
yum install -y ansible

echo 'Installing wget'
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

echo 'Create directory'
sudo mkdir /app && cd /app

echo 'Downloading nexus'

sudo wget https://sonatype-download.global.ssl.fastly.net/repository/repositoryManager/3/nexus-3.19.1-01-unix.tar.gz
tar xzf nexus-3.19.1-01-unix.tar.gz
ln -s nexus-3.19.1-01 nexus

echo 'Create Nexus user and provide permissions to nexus home directory'

useradd nexus
chown -R nexus:nexus /app/nexus

echo 'Configure Nexus to run as Service in Linux machine'

ln -s /app/nexus/bin/nexus /etc/init.d/nexus
chown nexus:nexus /etc/init.d/nexus
sudo chkconfig --add nexus
sudo systemctl enable nexus

echo 'Start the nexus service'

sudo service nexus start
