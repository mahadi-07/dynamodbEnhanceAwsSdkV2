# Service api key
echo "Inserting --> Service-X-API-Key"
aws ssm put-parameter --name "/uat/savings/service-x-api-key" --type SecureString  --value "R9yTFSYKb428eVmmXisjWCbCMWYkm0HZezZjlnoGqpX9dWBiki4joQIgag0JN2HJT7V24gIARIYB1jO0PEbE0IAS3WbUHtmHiDWcUWoXpgl1VBd4V0py6su5idjjBLunSDN" --overwrite --endpoint-url http://localhost:4566
