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

helm lint . --strict --set 'registry.kafka.bootstrapServers=kafka1'
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.kafka.bootstrap=kafka1'
if [ $? -eq 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.sql.url=c,registry.sql.existingSecret=a,registry.sql.existingSecretUsernameKey=b,registry.sql.existingSecretPasswordKey=d'
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.sql.url=c,registry.sql.existingSecret=a,registry.sql.existingSecretUsernameKey=b,registry.sql.existingSecretPassKey=d'
if [ $? -eq 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.extraEnv[0].name=qwe,registry.extraEnv[0].value=zzz'
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.extraEnv[0].name=qwe'
if [ $? -eq 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.extraEnv[0].name=qwe,registry.extraEnv[0].value=123'
if [ $? -eq 0 ]; then
  exit 1
fi

helm lint . --strict --set registry.ingress.enabled=true --set registry.ingress.tls=true
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set registry.ingress.enabled=true --set registry.ingress.path=null
if [ $? -eq 0 ]; then
  exit 1
fi

helm lint . --strict --set registry.ingress.enabled=true --set registry.ingress.host=null
if [ $? -eq 0 ]; then
  exit 1
fi

echo "=================================================================================="
echo "                                LINT PASSED"
echo "=================================================================================="
