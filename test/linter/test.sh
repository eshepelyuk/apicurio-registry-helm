#!/bin/bash
set -x

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
