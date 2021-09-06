#!/bin/sh
IP="`ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' | head -n 1`"
docker pull mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator
# https://docs.microsoft.com/en-us/azure/cosmos-db/linux-emulator?tabs=ssl-netstd21#run-on-linux
docker rm -f test-linux-emulator 2>/dev/null
rm ./.emulatorcert.crt 2>/dev/null
docker run --rm -d -p 8081:8081 -p 10251:10251 -p 10252:10252 -p 10253:10253 -p 10254:10254  -m 3g --cpus=2.0 --name=test-linux-emulator -e AZURE_COSMOS_EMULATOR_PARTITION_COUNT=10 -e AZURE_COSMOS_EMULATOR_ENABLE_DATA_PERSISTENCE=true -e AZURE_COSMOS_EMULATOR_IP_ADDRESS_OVERRIDE=127.0.0.1 -e AZURE_COSMOS_EMULATOR_KEY=C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw== -it mcr.microsoft.com/cosmosdb/linux/azure-cosmos-emulator
until curl -k https://127.0.0.1:8081/_explorer/emulator.pem
do
  sleep 5
  echo "Try again"
done
sleep 5
curl -k https://127.0.0.1:8081/_explorer/emulator.pem > ./.emulatorcert.crt