aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name devsit-savings-subscription-queue
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name devsit-savings-webhook-process-queue
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name devsit-savings-maturity-queue
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name devsit-savings-webhook-subscription-process-queue
aws --region ap-southeast-1 sqs create-queue --queue-name sit-savings-account-queue