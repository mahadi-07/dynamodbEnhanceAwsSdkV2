aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-organization --attribute-definitions AttributeName=organizationCode,AttributeType=S --key-schema AttributeName=organizationCode,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-product --attribute-definitions AttributeName=organizationCode,AttributeType=S AttributeName=productId,AttributeType=S --key-schema AttributeName=organizationCode,KeyType=HASH AttributeName=productId,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-settings --attribute-definitions AttributeName=key,AttributeType=S --key-schema AttributeName=key,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-customer-etin --attribute-definitions AttributeName=walletId,AttributeType=S --key-schema AttributeName=walletId,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-user --attribute-definitions AttributeName=email,AttributeType=S --key-schema AttributeName=email,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-notification --attribute-definitions AttributeName=event,AttributeType=S --key-schema AttributeName=event,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-user --item file://dynamodb/data/user1.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-user --item file://dynamodb/data/user2.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-user --item file://dynamodb/data/user3.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE

aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-organization --item file://dynamodb/data/idlc-org.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-organization --item file://dynamodb/data/cbl-org.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE

aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-settings --item file://dynamodb/data/product-types.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-settings --item file://dynamodb/data/mock-api-paths.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-settings --item file://dynamodb/data/mock-api-paths-v2.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE

aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-product --item file://dynamodb/data/IDLC-product-1.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-product --item file://dynamodb/data/IDLC-product-2.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-product --item file://dynamodb/data/CBL-product-1.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE

aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://dynamodb/data/notification/matured.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://dynamodb/data/notification/onboarding-success.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://dynamodb/data/notification/onboarding-failed.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://dynamodb/data/notification/cancellation-success.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://dynamodb/data/notification/cancellation-failed.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://dynamodb/data/notification/disbursement-success.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-notification --item file://dynamodb/data/notification/assisted-request-submitted.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE


aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-payment-history --attribute-definitions AttributeName=savingsId,AttributeType=S AttributeName=paymentId,AttributeType=N AttributeName=rppPaymentId,AttributeType=N --key-schema AttributeName=savingsId,KeyType=HASH AttributeName=paymentId,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5\
  --local-secondary-indexes "[{\"IndexName\": \"lsi-rppPaymentId\",\"KeySchema\":[{\"AttributeName\":\"savingsId\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"rppPaymentId\",\"KeyType\":\"RANGE\"}], \"Projection\":{\"ProjectionType\":\"ALL\"}}]"

aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-payment-history --attribute-definitions AttributeName=trxId,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"gsi-trxId\",\"KeySchema\":[{\"AttributeName\":\"trxId\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-payment-history --attribute-definitions AttributeName=trxShortDate,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"gsi-trxShortDate\",\"KeySchema\":[{\"AttributeName\":\"trxShortDate\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5      },\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"


aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-id-generator --attribute-definitions AttributeName=pk,AttributeType=S AttributeName=sk,AttributeType=S --key-schema AttributeName=pk,KeyType=HASH AttributeName=sk,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=500,WriteCapacityUnits=500
aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-account --attribute-definitions AttributeName=walletId,AttributeType=S AttributeName=savingsId,AttributeType=S AttributeName=fiAccountNo,AttributeType=S AttributeName=fiAccountId,AttributeType=S --key-schema AttributeName=walletId,KeyType=HASH AttributeName=savingsId,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=500,WriteCapacityUnits=500\
  --local-secondary-indexes \
  "[
    {\"IndexName\": \"lsi-fiAccountNo\",\"KeySchema\":[{\"AttributeName\":\"walletId\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"fiAccountNo\",\"KeyType\":\"RANGE\"}], \"Projection\":{\"ProjectionType\":\"ALL\"}},
    {\"IndexName\": \"lsi-fiAccountId\",\"KeySchema\":[{\"AttributeName\":\"walletId\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"fiAccountId\",\"KeyType\":\"RANGE\"}], \"Projection\":{\"ProjectionType\":\"ALL\"}}
  ]"

aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-account --attribute-definitions AttributeName=walletNo,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"gsi-walletNo\",\"KeySchema\":[{\"AttributeName\":\"walletNo\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5},\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-account --attribute-definitions AttributeName=rppSubscriptionRequestId,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"gsi-rppSubscriptionRequestId\",\"KeySchema\":[{\"AttributeName\":\"rppSubscriptionRequestId\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 500, \"WriteCapacityUnits\": 500},\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-account --attribute-definitions AttributeName=maturityShortDate,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"gsi-maturityShortDate\",\"KeySchema\":[{\"AttributeName\":\"maturityShortDate\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5},\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --endpoint-url http://localhost:4566 update-table --table-name dev-savings-account --attribute-definitions AttributeName=subscriptionRequestId,AttributeType=S --global-secondary-index-updates \
  "[{\"Create\":{\"IndexName\": \"gsi-subscriptionRequestId\",\"KeySchema\":[{\"AttributeName\":\"subscriptionRequestId\",\"KeyType\":\"HASH\"}], \
  \"ProvisionedThroughput\": {\"ReadCapacityUnits\": 10, \"WriteCapacityUnits\": 5},\"Projection\":{\"ProjectionType\":\"ALL\"}}}]"

aws dynamodb --endpoint-url http://localhost:4566 update-table \
    --table-name dev-savings-account \
    --attribute-definitions '[
      {
          "AttributeName": "startShortDate",
          "AttributeType": "S"
      },
      {
          "AttributeName": "currentState",
          "AttributeType": "S"
      }
    ]' \
    --global-secondary-index-updates '[
        {
            "Create": {
                "IndexName": "gsi-startShortDate-currentState",
                "KeySchema": [
                    {
                        "AttributeName": "startShortDate",
                        "KeyType": "HASH"
                    },
                    {
                        "AttributeName": "currentState",
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

# Create the main table for AssistedRequestEntity
aws dynamodb --endpoint-url http://localhost:4566 create-table \
  --table-name dev-savings-assisted-savings \
  --attribute-definitions AttributeName=requesterWalletId,AttributeType=S AttributeName=requestId,AttributeType=S AttributeName=savingsType,AttributeType=S AttributeName=organizationCode,AttributeType=S AttributeName=status,AttributeType=S AttributeName=requestCreateTime,AttributeType=S \
  --key-schema AttributeName=requesterWalletId,KeyType=HASH AttributeName=requestId,KeyType=RANGE \
  --provisioned-throughput ReadCapacityUnits=20,WriteCapacityUnits=20 \
  --local-secondary-indexes \
  "[
      {\"IndexName\": \"lsi-requesterWalletId-savingsType\",\"KeySchema\":[{\"AttributeName\":\"requesterWalletId\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"savingsType\",\"KeyType\":\"RANGE\"}], \"Projection\":{\"ProjectionType\":\"ALL\"}},
      {\"IndexName\": \"lsi-requesterWalletId-organizationCode\",\"KeySchema\":[{\"AttributeName\":\"requesterWalletId\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"organizationCode\",\"KeyType\":\"RANGE\"}], \"Projection\":{\"ProjectionType\":\"ALL\"}},
      {\"IndexName\": \"lsi-requesterWalletId-status\",\"KeySchema\":[{\"AttributeName\":\"requesterWalletId\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"status\",\"KeyType\":\"RANGE\"}], \"Projection\":{\"ProjectionType\":\"ALL\"}},
      {\"IndexName\": \"lsi-requesterWalletId-requestCreateTime\",\"KeySchema\":[{\"AttributeName\":\"requesterWalletId\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"requestCreateTime\",\"KeyType\":\"RANGE\"}], \"Projection\":{\"ProjectionType\":\"ALL\"}}
  ]"

# Add Global Secondary Indexes (GSIs)
aws dynamodb --endpoint-url http://localhost:4566 update-table \
    --table-name dev-savings-assisted-savings \
    --attribute-definitions '[
      {
          "AttributeName": "customerWalletId",
          "AttributeType": "S"
      },
      {
          "AttributeName": "requestId",
          "AttributeType": "S"
      }
    ]' \
    --global-secondary-index-updates '[
        {
            "Create": {
                "IndexName": "gsi-customerWalletId-requestId",
                "KeySchema": [
                    {
                        "AttributeName": "customerWalletId",
                        "KeyType": "HASH"
                    },
                    {
                        "AttributeName": "requestId",
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


aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-nominee --attribute-definitions AttributeName=walletId,AttributeType=S AttributeName=id,AttributeType=S --key-schema AttributeName=walletId,KeyType=HASH AttributeName=id,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5