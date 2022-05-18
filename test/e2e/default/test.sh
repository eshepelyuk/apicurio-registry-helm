#!/bin/bash
set -xeuo pipefail

APCRG="http GET :18080/apis/registry/v2"

${APCRG}/groups/default/artifacts | jq -e '.count==0'
kubectl apply -f "$(dirname $0)/../fixture.yaml"
sleep 15s

${APCRG}/groups/default/artifacts | jq -e '.count==1 and .artifacts[0].id=="pets-avro-id"'
