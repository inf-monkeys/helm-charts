<div align="center">

# Helm Chart for Monkeys

[![License](https://img.shields.io/github/license/inf-monkeys/monkeys-helm)](http://www.apache.org/licenses/LICENSE-2.0)
[![GitHub stars](https://img.shields.io/github/stars/inf-monkeys/monkeys-helm?style=social&label=Star&maxAge=2592000)](https://GitHub.com/inf-monkeys/monkeys-helm/stargazers/)
[![GitHub forks](https://img.shields.io/github/forks/inf-monkeys/monkeys-helm?style=social&label=Fork&maxAge=2592000)](https://github.com/inf-monkeys/monkeys-helm)

</div>

English | [中文](./README_zh.md)

## Description

This is a helm chart for [https://github.com/inf-monkeys/monkeys](https://github.com/inf-monkeys/monkeys)

## Requirements

You must have the following components installed on your machine, if not, read sepcific documentation.

1. [Docker runtime](https://docs.docker.com/engine/install/ubuntu/)
2. [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/).
3. [A Kubenetes cluster](https://minikube.sigs.k8s.io/docs/start/)
4. [Helm](https://helm.sh/docs/intro/install/)

## Usage

### Install the core service

1. Install the chart

```sh
git clone https://github.com/inf-monkeys/monkeys-cloud
cd monkeys-cloud/helm/charts/community/core

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add elastic https://helm.elastic.co
helm dependency build
helm install monkeys . --values ./values.yaml
```

2. Check status

```sh
kubectl get pods
kubectl get svc
```

3. Visit the service


By default `values.yaml` uses ClusterIP mode, you can visit monkeys web ui through **monkeys-proxy** service:

```sh
# Get current pod list
kubectl get pods 

# Port Forward monkey-proxy-xxxx-xxxx Pod, in this example use local machine's 8080 port.
kubectl port-forward --address 0.0.0.0 monkey-proxy-xxxx-xxxx 8080:80

# Try
curl http://localhost:8080
```

And if your service is behide a firewall, no forget to open that port.

### Update configuration

Create a new values file, `prod-values.yaml` for example.

For example if you want to modify server image version, add this to `prod-values.yaml`:

```yaml
images:
  server:
    tag: some-new-tag
```

Then run:

```sh
helm upgrade monkeys . --values ./values.yaml --values ./prod-values.yaml --namespace monkeys
```

### Install tools

Tools is by plug-in design, you can install as many tools as you like. Here are the list of avaiable tools:

- [monkey-tools-knowledge-base](./helm/charts/community/tools/monkey-tools-knowledge-base/README.md)
- [monkey-tools-sandbox](./helm/charts/community/tools/monkey-tools-sandbox/README.md)
- [monkey-tools-BepiPred3.0-Predictor](./helm/charts/community/tools/monkey-tools-BepiPred3.0-Predictor/README.md)
- [monkey-tools-midjourney](./helm/charts/community/tools/monkey-tools-midjourney/README.md)
- [monkey-tools-comfyui](./helm/charts/community/tools/monkey-tools-comfyui/README.md)

### Install OpenSource Components

- [vllm-openai](./helm/charts/community/opensource/vllm/README_zh.md)
