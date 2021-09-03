#!/bin/bash
apt-get update && apt-get install -y iputils-ping
connectendpoint=`ping -c 1 connect | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

 
echo "**********************************************" ${connectendpoint}
echo "Waiting for startup.."
echo "Started.."

echo cdcsetup.sh time now: `date +"%T" `\
apt-get update && apt-get install -y iputils-ping && apt-get install curl -y

#create connector
echo "------------------------------ CREATING A CONNECTOR TO SQL ------------------------------"
sleep 45
curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{
    "name": "sqlserver-person-connector1",
    "config": {
    "connector.class": "io.debezium.connector.sqlserver.SqlServerConnector",
    "database.hostname": "sqlserver",
    "database.server.name": "sqlserver",
    "database.port": "1433",
    "database.user": "sa",
    "database.password": "P@ssw0rd",
    "database.dbname": "TesteEF",
    "table.whitelist": "dbo.Person",
    "database.history.kafka.bootstrap.servers": "kafka:29092",
    "database.history.kafka.topic": "dbhistory.person"
  }
}' http://connector:8083/connectors/
echo "------------------------------ CONNECTOR SQL CREATED ------------------------------"