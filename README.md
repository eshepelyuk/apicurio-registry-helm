# Ultimate Helm chart for Apicurio Registry

* [Apicurio Registry](https://www.apicur.io/registry/)
* [Apicurio Registry GitHub](https://github.com/apicurio/apicurio-registry)
* [Apicurio Registry sync operator GitHub](https://github.com/Apicurio/apicurio-registry-content-sync-operator)

## Roadmap

* provide post installation validation instructions
* optionally create `Ingress`
* improve values schema linter tests
* contribute and migrate ownership to Apicurio team

Please, suggest more roadmap actions by opening an issue in this project.

## Installation

Apicurio Registry chart can be installed only with [Helm 3](https://helm.sh/docs).

The chart is published to [GitHub Container Registry
](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry).
Helm 3 CLI requires enabling [OCI registry support](https://helm.sh/docs/topics/registries/#enabling-oci-support)
for working with it.

```sh
export HELM_EXPERIMENTAL_OCI=1
```

### Install specific version

First, find the appropriate version from [available release
](https://github.com/eshepelyuk/apicurio-registry-helm-chart/releases).

Then, retrieve selected chart to a local directory using `${VERSION}` choosen.

```sh
helm pull oci://ghcr.io/eshepelyuk/apicurio-registry --version ${VERSION}
```

The command above should download a file names `apicurio-registry-${VERSION}.tgz`.

After that, chart is ready to be installed (or upgraded),
we suggest to install it into a dedicated namespace.

```sh
helm upgrade -i --wait --create-namespace -n apicurio myreg apicurio-registry-${VERSION}.tgz
```

