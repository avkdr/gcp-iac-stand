#!/bin/bash

echo 'Installing JDK'

sudo yum update -y
sudo yum install -y java-1.8.0-openjdk.x86_64

echo 'Create directory'
sudo mkdir /app && cd /app

echo 'Installing wget'

sudo yum install -y wget

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
