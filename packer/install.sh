#!/bin/bash

sudo apt-get install -y openjdk-7-jdk
sudo apt-get update
sudo apt-get install -y jenkins
apt-get install -y git
apt-get install -y ansible
curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share
mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven
ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
mv /tmp/settings.xml /root/.m2/settings.xml
USERNAME="${1}"
SSH_KEY=$(cat /tmp/id_rsa.pub)

adduser "${USERNAME}"
usermod -aG 'wheel' "${USERNAME}"

mkdir "/home/${USERNAME}/.ssh"
chown "${USERNAME}":"${USERNAME}" "/home/${USERNAME}/.ssh"
echo "${SSH_KEY}" | tee "/home/${USERNAME}/.ssh/authorized_keys"

chmod 600 "/home/${USERNAME}/.ssh/authorized_keys"
chown "${USERNAME}":"${USERNAME}" "/home/${USERNAME}/.ssh/authorized_keys"
