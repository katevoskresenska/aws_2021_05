#!/bin/bash

host="terraform-postgres.c5w3o8n3qvqd.us-west-2.rds.amazonaws.com"
db_name="postgres_db"
db_user="postgres"
sql_file="rds-script.sql"

echo "<----Installing required packages...---->"
sudo apt update
sudo apt install -y postgresql-client postgresql-client-common 

echo "<----Connecting to db...---->"
psql -U $db_user -h $host -d $db_name -f $sql_file