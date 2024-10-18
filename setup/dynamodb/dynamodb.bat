start cmd /C aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-organization --attribute-definitions AttributeName=organizationCode,AttributeType=S --key-schema AttributeName=organizationCode,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 
start cmd /C aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-product --attribute-definitions AttributeName=organizationCode,AttributeType=S AttributeName=productId,AttributeType=S --key-schema AttributeName=organizationCode,KeyType=HASH AttributeName=productId,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
start cmd /C aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-subscription --attribute-definitions AttributeName=walletNo,AttributeType=S AttributeName=subscriptionId,AttributeType=S --key-schema AttributeName=walletNo,KeyType=HASH AttributeName=subscriptionId,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
start cmd /C aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-miscellaneous --attribute-definitions AttributeName=key,AttributeType=S --key-schema AttributeName=key,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
start cmd /C aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-etin --attribute-definitions AttributeName=walletNo,AttributeType=S --key-schema AttributeName=walletNo,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
start cmd /C aws dynamodb --endpoint-url http://localhost:4566 create-table --table-name dev-savings-user --attribute-definitions AttributeName=email,AttributeType=S --key-schema AttributeName=email,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

start cmd /C aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-organization --item file://data/idlc-org.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
start cmd /C aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-organization --item file://data/cbl-org.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE


start cmd /C aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-product --item file://data/IDLC-product-1.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
start cmd /C aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-product --item file://data/IDLC-product-2.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
start cmd /C aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-product --item file://data/CBL-product-1.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE

start cmd /C aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-miscellaneous --item file://data/purposes.json --return-consumed-capacity TOTAL --return-item-collection-metrics 

start cmd /C aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-user --item file://data/user1.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
start cmd /C aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-user --item file://data/user2.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
start cmd /C aws dynamodb --endpoint-url http://localhost:4566 put-item --table-name dev-savings-user --item file://data/user3.json --return-consumed-capacity TOTAL --return-item-collection-metrics SIZE
