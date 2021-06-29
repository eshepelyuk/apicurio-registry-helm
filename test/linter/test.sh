#!/bin/bash

helm lint . --strict
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set registry=null
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set sync=null
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set 'sync.registryUrl=null'
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set 'sync.watchNamespaces=null'
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.kafka.bootstrapServers=kafka1'
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.kafka.bootstrap=kafka1'
if [ $? -eq 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.sql.url=c,registry.sql.username=a,registry.sql.password=b'
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.sql.url=c,registry.sql.username=a,registry.sql.pwd=b'
if [ $? -eq 0 ]; then
  exit 1
fi

echo "=================================================================================="
echo "                                LINT PASSED"
echo "=================================================================================="
