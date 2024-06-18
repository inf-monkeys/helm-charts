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

#### Install chart

```sh
# Add the helm repo
helm repo add monkeys https://inf-monkeys.github.io/helm-charts

# Install monkeys core service
helm install monkeys monkeys/core -n monkeys --create-namespace
```

#### Check status

> By default monkeys use internal middleware (postgres, elasticsearch, redis, etc), It may take some time to wait for middlewares startup.

Check installation progress by:

```sh
kubectl get pods -n monkeys
kubectl get svc -n monkeys
```

#### Visit the service


By default `values.yaml` uses ClusterIP mode, you can visit monkeys web ui through **monkeys-proxy** service:

```sh
# Get current pod list
kubectl get pods 

# Port Forward monkey-core-proxy-xxxx-xxxx Pod, in this example use local machine's 8080 port.
kubectl port-forward --address 0.0.0.0 monkey-core-proxy-xxxx-xxxx 8080:80 -n monkeys

# Try
curl http://localhost:8080
```

And if your service is behide a firewall, no forget to open that port.

### Update configuration

Create a new values file, `prod-core-values.yaml` for example.

For example if you want to modify server image version, add this to `prod-core-values.yaml`:

```yaml
images:
  server:
    tag: some-new-tag
```

Then run:

```sh
helm upgrade monkeys --values ./prod-core-values.yaml --namespace monkeys
```

For the complete list of configuration options, see: [Core Helm Chart](./charts/core/README.md)

#### Uninstall

```sh
helm uninstall monkeys -n monkeys
```

### Install tools

Tools is by plug-in design, you can install as many tools as you like. Here are the list of avaiable tools:

- [monkey-tools-knowledge-base](./charts/monkey-tools-knowledge-base/README.md)
- [monkey-tools-sandbox](./charts/monkey-tools-sandbox/README.md)
- [monkey-tools-BepiPred3.0-Predictor](./charts/monkey-tools-BepiPred3.0-Predictor/README.md)
- [monkey-tools-midjourney](./charts/monkey-tools-midjourney/README.md)
- [monkey-tools-comfyui](./charts/monkey-tools-comfyui/README.md)
- [monkey-tools-internet](./charts/monkey-tools-internet/README.md)
- [monkey-tools-social-media](./charts/monkey-tools-social-media/README.md)


### Install OpenSource Components

- [vllm-openai](./charts/vllm/README.md)
- [comfyui](./charts/comfyui/README.md)
