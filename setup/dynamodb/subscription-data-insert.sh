#!/bin/bash

# Define the endpoint URL
ENDPOINT_URL="http://localhost:4566"

# Define the table name
TABLE_NAME="dev-savings-subscription"

# Read the JSON file into an array
DATA_ARRAY=$(cat /path/to/your/json/file.json)

# Loop to insert each item
for item in "${DATA_ARRAY[@]}"; do
  aws dynamodb put-item --table-name $TABLE_NAME \
    --item "$item" \
    --endpoint-url $ENDPOINT_URL
done
