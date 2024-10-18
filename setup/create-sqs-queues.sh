aws sqs --endpoint-url http://localhost:4566 create-queue --queue-name SAVINGS_MATURITY_QUEUE
aws sqs --endpoint-url http://localhost:4566 create-queue --queue-name SAVINGS_CANCELATION_QUEUE
aws sqs --endpoint-url http://localhost:4566 create-queue --queue-name SAVINGS_BULK_PAYMENT_UPLOAD_QUEUE
aws sqs --endpoint-url http://localhost:4566 create-queue --queue-name SAVINGS_SUBSCRIPTION_QUEUE
