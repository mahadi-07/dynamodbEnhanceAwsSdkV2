aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/devsit/savings/api-key-from-idlc-to-bkash" --type SecureString --value "36ced1e3d340ee48001ba058eba9c548" --overwrite

aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/devsit/savings/api-key-from-bkash-to-idlc" --type SecureString  --value "d5d18afa-9403-43d3-afcf-60ede88a0da8" --overwrite

aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/devsit/savings/cimt-password" --type SecureString  --value "cimt54321" --overwrite

aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/devsit/savings/notification-authorization" --type SecureString  --value "Y3VzdG9tZXJBcHBOb3RpZmljYXRpb246ZjUxMTI3ZjUtMjJiMC00Njk5LTgzZGMtZWMwYjZjNDVhMGM4" --overwrite

aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/devsit/savings/x-api-key" --type SecureString  --value "V5hn-I-jmX6vV-YwjIpSMKBy76ZLXYz3" --overwrite