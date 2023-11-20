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

helm lint . --strict --set 'registry.sql.url=c,registry.sql.username=a,registry.sql.password=b'
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set 'registry.sql.url=c,registry.sql.username=a,registry.sql.pwd=b'
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

helm lint . --strict --set registry.nodeSelector.foo=bar
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set sync.nodeSelector.foo=bar
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set registry.initContainers[0].image=foo
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set sync.initContainers[0].image=foo
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set registry.initContainers.name=foo
if [ $? -eq 0 ]; then
  exit 1
fi

helm lint . --strict --set sync.initContainers.name=foo
if [ $? -eq 0 ]; then
  exit 1
fi

# extraVolumeMounts - correct
helm lint . --strict --set registry.extraVolumeMounts[0].name=foo,registry.extraVolumeMounts[0].mountPath=/bar
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set sync.extraVolumeMounts[0].name=foo,registry.extraVolumeMounts[0].mountPath=/bar
if [ $? -ne 0 ]; then
  exit 1
fi

# extraVolumeMounts - wrong
helm lint . --strict --set registry.extraVolumeMounts.name=foo,registry.extraVolumeMounts.mountPath=/bar
if [ $? -eq 0 ]; then
  exit 1
fi

helm lint . --strict --set sync.extraVolumeMounts.name=foo,registry.extraVolumeMounts.mountPath=/bar
if [ $? -eq 0 ]; then
  exit 1
fi

# extraVolumes - correct
helm lint . --strict --set registry.extraVolumes[0].name=foo,registry.extraVolumes[0].emptyDir=true
if [ $? -ne 0 ]; then
  exit 1
fi

helm lint . --strict --set sync.extraVolumes[0].name=foo,sync.extraVolumes[0].emptyDir=true
if [ $? -ne 0 ]; then
  exit 1
fi

# extraVolumes - wrong
helm lint . --strict --set registry.extraVolumes.name=foo,registry.extraVolumes.emptyDir=true
if [ $? -eq 0 ]; then
  exit 1
fi

helm lint . --strict --set sync.extraVolumes.name=foo,sync.extraVolumes.emptyDir=true
if [ $? -eq 0 ]; then
  exit 1
fi


echo "=================================================================================="
echo "                                LINT PASSED"
echo "=================================================================================="
