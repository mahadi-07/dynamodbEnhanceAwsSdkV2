#aws --endpoint-url=http://localhost:4566 s3 mb s3://bucket

#aws --endpoint-url=http://localhost:4566 s3 cp ./s3/server.truststore s3://bucket

aws --endpoint-url=http://localhost:4566 s3 mb s3://dev
aws --endpoint-url=http://localhost:4566 s3 cp ./s3/callback.pgw.com-keystore.jks  s3://dev
aws --endpoint-url=http://localhost:4566 s3 cp ./s3/callback.pgw.com-truststore.jks  s3://dev
