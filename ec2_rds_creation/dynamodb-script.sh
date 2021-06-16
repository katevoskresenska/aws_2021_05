#!/bin/bash

echo "<----Listing available tables...---->"
aws dynamodb list-tables \
    --region us-west-2


echo "<----Adding the first item...---->"
aws dynamodb put-item \
    --table-name a_table  \
    --item \
        '{"Id": {"N": "1"}, "Text": {"S": "Text 1"}, "DateTime": {"S": "2021-06-16T17:42:34Z"} }' \
    --region us-west-2

echo "<----Adding the second item...---->"
aws dynamodb put-item \
    --table-name a_table \
    --item \
        '{"Id": {"N": "2"}, "Text": {"S": "Text 2"}, "DateTime": {"S": "2021-06-16T18:15:04Z"} }' \
    --region us-west-2

echo "<----Retrieving the first item...---->"
aws dynamodb get-item \
    --table-name a_table \
    --key '{"Id": {"N": "1"}, "DateTime": {"S": "2021-06-16T17:42:34Z"}}' \
    --region us-west-2

echo "<----Retrieving the second item...---->"
aws dynamodb get-item \
    --table-name a_table \
    --key '{"Id": {"N": "2"}, "DateTime": {"S": "2021-06-16T18:15:04Z"}}' \
    --region us-west-2
