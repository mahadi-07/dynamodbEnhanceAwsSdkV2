#!/bin/bash

clear
echo "starting docker for savings-dps"
docker-compose up -d
echo "started docker for savings-dps"
echo "database commands execution started"
sh config/dynamodb/dynamodb.sh
echo "database commands execution complete"
echo "SSM commands execution started"
sh config/ssm-parameters.sh
echo "SSM commands execution complete"
echo "SQS commands execution started"
sh config/sqs.sh
echo "SQS commands execution complete"
DYNAMO_ENDPOINT=http://localhost:4566 dynamodb-admin --open