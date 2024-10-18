aws ssm put-parameter --name "/sit/savings/api-key-for-idlc" --type String --value "36ced1e3d340ee48001ba058eba9c548" --region ap-southeast-1 --overwrite

aws ssm put-parameter --name "/sit/savings/api-key-of-idlc" --type String  --value "c132fcdc-b50c-4825-97f3-92b28476d626" --region ap-southeast-1 --overwrite

aws ssm put-parameter --name "/sit/savings/cimt-password" --type SecureString  --value "cimt54321" --region ap-southeast-1 --overwrite

aws ssm put-parameter --name "/sit/savings/notification-authorization" --type SecureString  --value "Y3VzdG9tZXJBcHBOb3RpZmljYXRpb246ZjUxMTI3ZjUtMjJiMC00Njk5LTgzZGMtZWMwYjZjNDVhMGM4" --region ap-southeast-1 --overwrite

aws ssm put-parameter --name "/sit/savings/x-api-key" --type String  --value "V5hn-I-jmX6vV-YwjIpSMKBy76ZLXYz3" --region ap-southeast-1 --overwrite

aws ssm put-parameter --name "/sit/savings/azure-client-secret" --type SecureString  --value "XMD8Q~YqgSgbAf2LnEagS1AXCygXFB.H3wcc~b-n" --region ap-southeast-1 --overwrite

aws ssm put-parameter --name "/sit/savings/azure-tenant-id" --type SecureString  --value "64f212b1-446a-4980-bc21-c1d41f7eafa8" --region ap-southeast-1 --overwrite

# Service api key
echo "Inserting --> Service-X-API-Key"
aws ssm put-parameter --name "/sit/savings/service-x-api-key" --type SecureString  --value "JiSarP5P3MAGTfJzoPh2NbLDWJdIsosJ0qnH3mVGfXvFwcz2pRlWHI2nja96yjboYKSrBzPBdlw3qQsJpz0yioyCiApGlLI7HTq1suWCxdLh66TFAfMt8rsZT3AscDbLrq2B" --overwrite --endpoint-url http://localhost:4566

