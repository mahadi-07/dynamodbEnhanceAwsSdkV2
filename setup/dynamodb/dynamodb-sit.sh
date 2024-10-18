aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-organization --attribute-definitions AttributeName=organizationCode,AttributeType=S --key-schema AttributeName=organizationCode,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-product --attribute-definitions AttributeName=organizationCode,AttributeType=S AttributeName=productId,AttributeType=S --key-schema AttributeName=organizationCode,KeyType=HASH AttributeName=productId,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-subscription --attribute-definitions AttributeName=walletNo,AttributeType=S AttributeName=rppSubscriptionRequestId,AttributeType=S AttributeName=accountNo,AttributeType=S --key-schema AttributeName=walletNo,KeyType=HASH AttributeName=rppSubscriptionRequestId,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --local-secondary-indexes \
 		"[{\"IndexName\": \"index-accountNo\",
        \"KeySchema\":[{\"AttributeName\":\"walletNo\",\"KeyType\":\"HASH\"},
                      {\"AttributeName\":\"accountNo\",\"KeyType\":\"RANGE\"}],
        \"Projection\":{\"ProjectionType\":\"ALL\"}}]"

aws dynamodb --region ap-southeast-1 update-table --table-name sit-savings-subscription --attribute-definitions AttributeName=rppSubscriptionRequestId,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"index-rppSubscriptionRequestId\",\"KeySchema\":[{\"AttributeName\":\"rppSubscriptionRequestId\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-miscellaneous --attribute-definitions AttributeName=key,AttributeType=S --key-schema AttributeName=key,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-etin --attribute-definitions AttributeName=walletNo,AttributeType=S --key-schema AttributeName=walletNo,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-user --attribute-definitions AttributeName=email,AttributeType=S --key-schema AttributeName=email,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-payment --attribute-definitions AttributeName=subscriptionRequestId,AttributeType=S AttributeName=paymentId,AttributeType=N --key-schema AttributeName=subscriptionRequestId,KeyType=HASH AttributeName=paymentId,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-notification --attribute-definitions AttributeName=event,AttributeType=S --key-schema AttributeName=event,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

aws dynamodb --region ap-southeast-1 update-table --table-name sit-savings-subscription --attribute-definitions AttributeName=maturityShortDate,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"index-maturityShortDate\",\"KeySchema\":[{\"AttributeName\":\"maturityShortDate\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --region ap-southeast-1 update-table --table-name sit-savings-payment --attribute-definitions AttributeName=trxId,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"index-trxId\",\"KeySchema\":[{\"AttributeName\":\"trxId\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --region ap-southeast-1 put-item --table-name dev-savings-miscellaneous --item file://idlc-api-paths-sit.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --region ap-southeast-1 put-item --table-name dev-savings-user --item file://user1.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --region ap-southeast-1 put-item --table-name dev-savings-user --item file://user2.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --region ap-southeast-1 put-item --table-name dev-savings-user --item file://user3.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE

aws dynamodb --region ap-southeast-1 update-table --table-name sit-savings-subscription --attribute-definitions AttributeName=subscriptionRequestId,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"index-subscriptionRequestId\",\"KeySchema\":[{\"AttributeName\":\"subscriptionRequestId\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-product-history --attribute-definitions AttributeName=productId,AttributeType=S AttributeName=lastModifiedDate,AttributeType=N --key-schema AttributeName=productId,KeyType=HASH AttributeName=lastModifiedDate,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

aws dynamodb --region ap-southeast-1 update-table --table-name sit-savings-payment --attribute-definitions AttributeName=trxShortDate,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"index-trxShortDate\",\"KeySchema\":[{\"AttributeName\":\"trxShortDate\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"


aws dynamodb --region ap-southeast-1 update-table \
    --table-name sit-savings-subscription \
    --attribute-definitions '[
      {
          "AttributeName": "startShortDate",
          "AttributeType": "S"
      },
      {
          "AttributeName": "currentStatus",
          "AttributeType": "S"
      }
    ]' \
    --global-secondary-index-updates '[
        {
            "Create": {
                "IndexName": "index-startShortDate-currentStatus",
                "KeySchema": [
                    {
                        "AttributeName": "startShortDate",
                        "KeyType": "HASH"
                    },
                    {
                        "AttributeName": "currentStatus",
                        "KeyType": "RANGE"
                    }
                ],
                "Projection": {
                    "ProjectionType": "ALL"
                },
                "ProvisionedThroughput": {
                    "ReadCapacityUnits": 10,
                    "WriteCapacityUnits": 5
                }
            }
        }
    ]'

aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-seq-id-gen --attribute-definitions AttributeName=pk,AttributeType=S AttributeName=sk,AttributeType=S --key-schema AttributeName=pk,KeyType=HASH AttributeName=sk,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --region ap-southeast-1 create-table --table-name sit-savings-id-generator --attribute-definitions AttributeName=pk,AttributeType=S AttributeName=sk,AttributeType=S --key-schema AttributeName=pk,KeyType=HASH AttributeName=sk,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
