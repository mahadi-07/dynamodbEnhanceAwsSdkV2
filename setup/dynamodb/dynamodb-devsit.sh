aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-organization --attribute-definitions AttributeName=organizationCode,AttributeType=S --key-schema AttributeName=organizationCode,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-product --attribute-definitions AttributeName=organizationCode,AttributeType=S AttributeName=productId,AttributeType=S --key-schema AttributeName=organizationCode,KeyType=HASH AttributeName=productId,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-subscription --attribute-definitions AttributeName=walletNo,AttributeType=S AttributeName=rppSubscriptionRequestId,AttributeType=S AttributeName=accountNo,AttributeType=S --key-schema AttributeName=walletNo,KeyType=HASH AttributeName=rppSubscriptionRequestId,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --local-secondary-indexes \
 		"[{\"IndexName\": \"index-accountNo\",
        \"KeySchema\":[{\"AttributeName\":\"walletNo\",\"KeyType\":\"HASH\"},
                      {\"AttributeName\":\"accountNo\",\"KeyType\":\"RANGE\"}],
        \"Projection\":{\"ProjectionType\":\"ALL\"}}]"

aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-subscription --attribute-definitions AttributeName=rppSubscriptionRequestId,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"index-rppSubscriptionRequestId\",\"KeySchema\":[{\"AttributeName\":\"rppSubscriptionRequestId\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-miscellaneous --attribute-definitions AttributeName=key,AttributeType=S --key-schema AttributeName=key,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-etin --attribute-definitions AttributeName=walletNo,AttributeType=S --key-schema AttributeName=walletNo,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-user --attribute-definitions AttributeName=email,AttributeType=S --key-schema AttributeName=email,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-payment --attribute-definitions AttributeName=subscriptionRequestId,AttributeType=S AttributeName=paymentId,AttributeType=N --key-schema AttributeName=subscriptionRequestId,KeyType=HASH AttributeName=paymentId,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-notification --attribute-definitions AttributeName=event,AttributeType=S --key-schema AttributeName=event,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-shedlock --attribute-definitions AttributeName=_id,AttributeType=S --key-schema AttributeName=_id,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5


aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-subscription --attribute-definitions AttributeName=maturityShortDate,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"index-maturityShortDate\",\"KeySchema\":[{\"AttributeName\":\"maturityShortDate\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-payment --attribute-definitions AttributeName=trxId,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"index-trxId\",\"KeySchema\":[{\"AttributeName\":\"trxId\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-organization --item file://config/dynamodb/data/idlc-org-devsit.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-organization --item file://config/dynamodb/data/cbl-org.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-miscellaneous --item file://config/dynamodb/data/product-types.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-user --item file://config/dynamodb/data/user1.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-user --item file://config/dynamodb/data/user2.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-user --item file://config/dynamodb/data/user3.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-miscellaneous --item file://config/dynamodb/data/idlidlc-api-paths-devsit.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE

aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-product --item file://config/dynamodb/data/IDLC-product-1.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-product --item file://config/dynamodb/data/IDLC-product-2.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-product --item file://config/dynamodb/data/CBL-product-1.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE

aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://config/dynamodb/data/notification/matured.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://config/dynamodb/data/notification/onboarding-success.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://config/dynamodb/data/notification/onboarding-failed.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://config/dynamodb/data/notification/cancellation-success.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://config/dynamodb/data/notification/cancellation-failed.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://config/dynamodb/data/notification/disbursement-success.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE

aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-subscription --attribute-definitions AttributeName=subscriptionRequestId,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"index-subscriptionRequestId\",\"KeySchema\":[{\"AttributeName\":\"subscriptionRequestId\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"
  
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-product-history --attribute-definitions AttributeName=productId,AttributeType=S AttributeName=lastModifiedDate,AttributeType=N --key-schema AttributeName=productId,KeyType=HASH AttributeName=lastModifiedDate,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-payment --attribute-definitions AttributeName=trxShortDate,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"index-trxShortDate\",\"KeySchema\":[{\"AttributeName\":\"trxShortDate\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"


aws dynamodb --endpoint-url http://localhost:4566 update-table \
    --table-name dev-savings-subscription \
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