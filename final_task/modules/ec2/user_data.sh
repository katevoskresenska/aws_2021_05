#!/bin/bash 
set -xe
bucket_name="iamkatyu-finaltask-bucket"

sudo apt update
sudo apt install -y openjdk-8-jdk awscli
aws s3 cp s3://$bucket_name/calc-0.0.2-SNAPSHOT.jar /home/ubuntu/calc-0.0.2-SNAPSHOT.jar

sleep 300

sudo java -jar calc-0.0.2-SNAPSHOT.jar & > log.txt