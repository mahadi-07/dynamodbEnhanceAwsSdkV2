@echo off

clear
echo "starting docker for savings-dps"
docker-compose up -d
echo "started docker for savings-dps"
echo "database commands execution started"
call /config/dynamodb/dynamodb.bat
echo "database commands execution complete"