#!/bin/bash

echo 'Installing JDK'

sudo yum update -y
sudo yum install -y java-1.8.0-openjdk.x86_64

echo 'Installing git'

sudo yum install git -y
