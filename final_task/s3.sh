#!/bin/bash

files_to_upload=("jars/calc-0.0.2-SNAPSHOT.jar" "jars/persist3-0.0.1-SNAPSHOT.jar")
bucket_name="iamkatyu-finaltask-bucket"
acl="private"
location="us-west-2"

echo "<----Creating AWS S3 bucket...---->"
aws s3api create-bucket --bucket $bucket_name --region $location --acl $acl --create-bucket-configuration LocationConstraint=$location

echo "<----Adding versioning to AWS S3 bucket...---->"
aws s3api put-bucket-versioning --bucket $bucket_name --versioning-configuration Status=Enabled

echo "<----Uploading files to AWS S3 bucket...---->"

for file in ${files_to_upload[@]}; do
   aws s3 cp $file s3://$bucket_name/
done

echo "<----Listing to AWS S3 bucket...---->"
aws s3 ls s3://$bucket_name/