aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/api-key-for-idlc" --type String --value "bkash.idlc.001" --overwrite
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/api-key-for-cbl" --type String  --value "bkash.cbl.002" --overwrite
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/api-key-for-bbl" --type String  --value "bkash.bbl.003" --overwrite


aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/api-key-of-idlc" --type String  --value "idlc.bkash.004" --overwrite
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/api-key-of-cbl" --type String   --value "cbl.bkash.005" --overwrite
aws ssm --endpoint-url http://localhost:4566 put-parameter --name "/dev/savings/api-key-of-bbl" --type String   --value "bbl.bkash.006" --overwrite
