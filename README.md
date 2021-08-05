# Ultimate Helm chart for Apicurio Registry

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/eshepelyuk/apicurio-registry-helm/CI?label=CI%2FCD&style=for-the-badge)
[![Current](https://img.shields.io/github/v/tag/eshepelyuk/apicurio-registry-helm?logo=github&sort=semver&style=for-the-badge&label=current)](https://github.com/eshepelyuk/apicurio-registry-helm/releases/latest)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/apicurio-registry-helm&style=for-the-badge)](https://artifacthub.io/packages/helm/apicurio-registry-helm/apicurio-registry)
[![MIT License](https://img.shields.io/github/license/eshepelyuk/cmak-operator?logo=mit&style=for-the-badge)](https://opensource.org/licenses/MIT)

* [Apicurio Registry](https://www.apicur.io/registry/)
* [Apicurio Registry GitHub](https://github.com/apicurio/apicurio-registry)
* [Apicurio Registry sync operator GitHub](https://github.com/Apicurio/apicurio-registry-content-sync-operator)

## Installation

The chart is published to [GitHub Container Registry
](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
and can be installed only with [Helm 3](https://helm.sh/docs).

Helm 3 CLI requires enabling [OCI registry support](https://helm.sh/docs/topics/registries/#enabling-oci-support).

```sh
export HELM_EXPERIMENTAL_OCI=1
```

First, find the appropriate version from [available releases
](https://github.com/eshepelyuk/apicurio-registry-helm-chart/releases) list.

Then, download the chart with choosen `${VERSION}` to a local directory.

```sh
helm pull oci://ghcr.io/eshepelyuk/apicurio-registry --version ${VERSION}
```

The command above will download a file named `apicurio-registry-${VERSION}.tgz`.

After that, chart is ready to be installed (or upgraded),
we suggest to install it into a dedicated namespace.

```sh
helm upgrade -i --wait --create-namespace -n apicurio myreg apicurio-registry-${VERSION}.tgz
```

## Access Apicuruio Registry UI

1. Forward local port to installed registry instance

```sh
kubectl port-forward service/myreg-apicurio-registry 8080:8080
```

2. Open your browser at

    http://localhost:8080

## Configuration

Chart parameters can be configured via [Helm values files](https://helm.sh/docs/chart_template_guide/values_files/).

Check out [values schema](https://artifacthub.io/packages/helm/apicurio-registry-helm/apicurio-registry?modal=values-schema)
for the available configuration options.

## Contribution

Your contributions like feature suggesstions, bug reports and pull requests are always welcomed.
Please check [CONTRIBUTING page](./CONTRIBUTING.adoc) for details.
