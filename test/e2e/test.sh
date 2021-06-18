#!/bin/sh

if [ $# -ne 1 ]; then
  echo "Usage: test.sh HOST:PORT"
  exit 1
fi

set -x
set -e

API_URL="http://$1/apis/registry/v2"

CNT=$(curl -fs ${API_URL}/groups/default/artifacts | jq '.count')
if [ $CNT -ne 0 ]; then
  echo "Check #1 failed: $CNT != 0"
  exit 1
fi

kubectl apply -f "$(dirname $0)/manifest/avro-example.yaml"
sleep 10s

RES=$(curl -fs ${API_URL}/groups/default/artifacts | jq '.count == 1 and .artifacts[0].id == "pets-avro-id"')
if [ $RES != 'true' ]; then
  echo "Check #2 failed"
  curl -fs ${API_URL}/groups/default/artifacts | jq .
  exit 1
fi
