#!/bin/bash

file_to_upload="hello_file.txt"
bucket_name="iamkatyu-first-bucket"
acl="private"
location="us-west-2"

echo "<----Creting a simple text file...---->"
echo "Hello World" > $file_to_upload

echo "<----Creating AWS S3 bucket...---->"
aws s3api create-bucket --bucket $bucket_name --region $location --acl $acl --create-bucket-configuration LocationConstraint=$location

echo "<----Adding versioning to AWS S3 bucket...---->"
aws s3api put-bucket-versioning --bucket $bucket_name --versioning-configuration Status=Enabled

echo "<----Uploading a_file.txt to AWS S3 bucket...---->"
aws s3 cp $file_to_upload s3://$bucket_name/

echo "<----Listing to AWS S3 bucket...---->"
aws s3 ls s3://$bucket_name/
