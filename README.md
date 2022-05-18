# Ultimate Helm chart for Apicurio Registry

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/eshepelyuk/apicurio-registry-helm/CI?label=CI%2FCD&style=for-the-badge)
[![Current](https://img.shields.io/github/v/tag/eshepelyuk/apicurio-registry-helm?logo=github&sort=semver&style=for-the-badge&label=current)](https://github.com/eshepelyuk/apicurio-registry-helm/releases/latest)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/apicurio-registry-helm&style=for-the-badge)](https://artifacthub.io/packages/helm/apicurio-registry-helm/apicurio-registry)
[![MIT License](https://img.shields.io/github/license/eshepelyuk/cmak-operator?logo=mit&style=for-the-badge)](https://opensource.org/licenses/MIT)

* [Apicurio Registry](https://www.apicur.io/registry/)
* [Apicurio Registry GitHub](https://github.com/apicurio/apicurio-registry)
* [Apicurio Registry sync operator GitHub](https://github.com/Apicurio/apicurio-registry-content-sync-operator)

## Installation

`apicurio-registry` chart is published into OCI compatible registry
and requires Helm version >= 3.8.

It's recommended to install Apicurio Registry into a dedicated namespace.
To install specific `VERSION` use following command.

```sh
helm upgrade -i --wait --create-namespace -n apicurio apicurio-registry \
  oci://ghcr.io/eshepelyuk/helm/apicurio-registry --version <VERSION>
```

To install the latest version - omit `--version` flag from previous command.

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

