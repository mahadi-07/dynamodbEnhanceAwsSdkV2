aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name dev-savings-account-queue --attributes DelaySeconds=10,VisibilityTimeout=120
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name dev-savings-assisted-commission-queue --attributes DelaySeconds=10,VisibilityTimeout=120
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name dev-savings-maturity-queue

#  aws sqs purge-queue --queue-url http://localhost:4566/000000000000/dev-savings-rpp-delay-status-query-queue --endpoint-url=http://localhost:4566

aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name dev-savings-installment-pay-queue --attributes DelaySeconds=10,VisibilityTimeout=30

aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name dev-savings-schedulerFailedPendingMaturity-queue --attributes DelaySeconds=10,VisibilityTimeout=120

aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name dev-savings-account-cancellation-queue

