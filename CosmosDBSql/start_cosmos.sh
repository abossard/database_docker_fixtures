#!/bin/sh
IP="`ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' | head -n 1`"
docker pull mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator
# https://docs.microsoft.com/en-us/azure/cosmos-db/linux-emulator?tabs=ssl-netstd21#run-on-linux
docker run --rm -p 8081:8081 -p 10251:10251 -p 10252:10252 -p 10253:10253 -p 10254:10254  -m 3g --cpus=2.0 --name=test-linux-emulator -e AZURE_COSMOS_EMULATOR_PARTITION_COUNT=10 -e AZURE_COSMOS_EMULATOR_ENABLE_DATA_PERSISTENCE=true -e AZURE_COSMOS_EMULATOR_IP_ADDRESS_OVERRIDE=$IP -it mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator
docker run --rm -p 8081:8081 -p 10251:10251 -p 10252:10252 -p 10253:10253 -p 10254:10254  -m 3g --cpus=2.0 --name=test-linux-emulator -e AZURE_COSMOS_EMULATOR_PARTITION_COUNT=10 -e AZURE_COSMOS_EMULATOR_ENABLE_DATA_PERSISTENCE=true  -it mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator
NODE_TLS_REJECT_UNAUTHORIZED=0
curl -k https://192.168.81.129:8081/_explorer/emulator.pem > ./.emulatorcert.crt
curl -k https://localhost:8081/_explorer/emulator.pem > ./.emulatorcert.crt