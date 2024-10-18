echo "Inserting --> apiKeyFromIdlcToBkash"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/api-key-from-idlc-to-bkash" --type SecureString --value "36ced1e3d340ee48001ba058eba9c548" --overwrite
echo "Inserting --> apiKeyFromBkashToIdlc"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/api-key-from-bkash-to-idlc" --type SecureString  --value "d5d18afa-9403-43d3-afcf-60ede88a0da8" --overwrite
echo "Inserting --> cimtPassword"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/cimt-password" --type SecureString  --value "cimt54321" --overwrite
echo "Inserting --> aesSecretKey"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/aes-secret-key" --type SecureString  --value "cQfTjWnZr4u7x!A%C*F-JaNdRgUkXp2s" --overwrite
echo "Inserting --> notificationAuthorization"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/notification-authorization" --type SecureString  --value "Y3VzdG9tZXJBcHBOb3RpZmljYXRpb246ZjUxMTI3ZjUtMjJiMC00Njk5LTgzZGMtZWMwYjZjNDVhMGM4" --overwrite
echo "Inserting --> xApiKey"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/x-api-key" --type SecureString  --value "RqRyxjRzgeGBhg-WBzijWRGebj5nfgOT" --overwrite
echo "Inserting --> azureClientSecret"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/azure-client-secret" --type SecureString  --value "gAE8Q~2FUNC1XdZNBSTPWkvpt0_wucjiomsGrcrL" --overwrite
echo "Inserting --> azureTenantId"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/azure-tenant-id" --type SecureString  --value "64f212b1-446a-4980-bc21-c1d41f7eafa8" --overwrite
echo "Inserting --> mappServiceKey"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/mapp-service-key" --type SecureString  --value "CTCB3Wty6gJTtbtVpyaQPPUA4Dl0e0n9" --overwrite
echo "Inserting --> aappServiceKey"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/aapp-service-key" --type SecureString  --value "5N04XRqfvy8FmxkAnvPgY3YE8JKeXWAQ" --overwrite
echo "Inserting --> cappServiceKey"
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/capp-service-key" --type SecureString  --value "5EkOzW18YPyThppQGnkf9cOKTW4nNDA1" --overwrite

# Service api key
echo "Inserting --> Service-X-API-Key"
aws ssm put-parameter --name "/dev/savings/service-x-api-key" --type SecureString  --value "7Tt9UOgYaOvwZIto4kWTLe3YpSDo8NtlFOZFvGFFnsSnN8CKUF3RtU6s0UtdDqDhff9RH4L4PDD6u5v710l3VmyLoUuiiGCj3ajOitg5ElnsEcjtodPxmG9eaZpRuLIKGEo" --overwrite --endpoint-url http://localhost:4566


# cps related dependency
echo "Inserting --> Savings initiatorIdentifierType";
aws ssm put-parameter --name "/dev/savings/initiator-identifier-type" --type String --value "11" --overwrite --region "ap-southeast-1" --endpoint-url http://localhost:4566;
echo "Inserting --> Savings orgOperatorId";
aws ssm put-parameter --name "/dev/savings/org-operator-id" --type String --value "testOp3" --overwrite --region "ap-southeast-1" --endpoint-url http://localhost:4566;
echo "Inserting --> Savings orgOperatorPass";
aws ssm put-parameter --name "/dev/savings/org-operator-pass" --type String --value "qMNFTm2NsMBmRxfR7D0n7K1ZaU1d57xN1UZL24ynT+wxRuoMdc2rzqJm6mRc59Drvxat+awDZWTxgIrtKPLuaCNwMUZBW/d1/w2lwbMCUdrMHXdq+vFLdk8cVQlvWYmMKEBYYxInR7synwvuzR1Eyb2qd+lDnhNjwYDjic+itIJIe3PRvmMwj6LFbZeuHorBI1UtAQEUq5DC2n9qto1AcH0BIij/Yuo73GWSMdUd3UbvjjK9YFeZMZO032bDZVROX79ffQNWr3en4FLWWx9wb3nfC0n5WVWGQKKhAe5jFhS2YG9Wc8/ncFhLm8l1PMRdRRJ/ne0VaBUwE5qgN3hb4g==" --overwrite --region "ap-southeast-1" --endpoint-url http://localhost:4566;