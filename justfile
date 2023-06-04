export E2E_TEST := "default"

default:
  @just --list

test-lint:
	./test/linter/test.sh

test-unit:
	helm plugin ls | grep unittest || helm plugin install https://github.com/quintush/helm-unittest
	helm unittest -f 'test/unit/*.yaml' .

test: test-lint test-unit

_skaffold-ctx:
  skaffold config set default-repo localhost:5000

# (re) create local k8s cluster using k3d
k3d: && _skaffold-ctx
  k3d cluster rm apcrg || true
  k3d cluster create --config ./test/e2e/k3d.yaml
  sleep 20
  kubectl rollout status deploy traefik -n kube-system --timeout=2m

# install into local k8s
up: _skaffold-ctx down
  skaffold run

# remove from local k8s
down:
  skaffold delete || true

# run only e2e test script
test-e2e-sh:
  kubectl delete artifact -l apcrg/e2e=true || true
  ./test/e2e/{{E2E_TEST}}/test.sh

# run single e2e test
test-e2e: up test-e2e-sh

