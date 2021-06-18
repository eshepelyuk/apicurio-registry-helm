# Ultimate Helm chart for Apicurio Registry

* [Apicurio Registry](https://www.apicur.io/registry/)
* [Apicurio Registry GitHub](https://github.com/apicurio/apicurio-registry)
* [Apicurio Registry sync operator GitHub](https://github.com/Apicurio/apicurio-registry-content-sync-operator)

## Roadmap

* values schema validation
* improved values schema linter tests
* support registry deployment with various backend (SQL, kafka, etc)
* contribute and migrate ownership to Apicurio team

Please, suggest more raodmap actions by opening an issue in this project.

## Installation

Apicurio Registry chart can be installed only with [Helm 3](https://helm.sh/docs).

The chart is published to public [GitHub Container Registry
](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry).
It requires enabling [OCI registry support](https://helm.sh/docs/topics/registries/#enabling-oci-support).

```sh
export HELM_EXPERIMENTAL_OCI=1
```

### Install specific version

Check for the list of all available versions
at [Release Page](https://github.com/eshepelyuk/apicurio-registry-helm-chart/releases).

First, retrieve selected chart version to a local directory.

```sh
helm pull oci://ghcr.io/eshepelyuk/apicurio-registry --version ${VERSION}
```

The command above should download a file names `apicurio-registry-${VERSION}.tgz`.

Chart is ready to be installed, we suggest to install it into a dedicated namespace.

```sh
helm upgrade -i --wait --create-namespace -n apicurio myreg apicurio-registry-${VERSION}.tgz
```

