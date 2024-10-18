#!/bin/bash

clear
echo "starting docker for savings-dps"
docker compose up -d
echo "waiting 5 seconds for docker to come online"
sleep 5

echo "database commands execution started"
sh dynamodb/dynamodb.sh
echo "database commands execution completed"

echo "SSM commands execution started"
sh ssm-parameters.sh
echo "SSM commands execution completed"

echo "SQS commands execution started"
sh sqs.sh
echo "SQS commands execution completed"

echo "S3 commands execution started"
sh s3/s3.sh
echo "S3 commands execution completed"

DYNAMO_ENDPOINT=http://localhost:4566 dynamodb-admin --open
