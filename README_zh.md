<div align="center">

# Monkeys Helm Chart 

[![License](https://img.shields.io/github/license/inf-monkeys/monkeys-helm)](http://www.apache.org/licenses/LICENSE-2.0)
[![GitHub stars](https://img.shields.io/github/stars/inf-monkeys/monkeys-helm?style=social&label=Star&maxAge=2592000)](https://GitHub.com/inf-monkeys/monkeys-helm/stargazers/)
[![GitHub forks](https://img.shields.io/github/forks/inf-monkeys/monkeys-helm?style=social&label=Fork&maxAge=2592000)](https://github.com/inf-monkeys/monkeys-helm)

</div>

## 描述

此项目为 [https://github.com/inf-monkeys/monkeys](https://github.com/inf-monkeys/monkeys) 提供的官方 helm chart。

## 依赖

请确保你的服务器上已经安装了以下依赖，如果没有，你可以阅读相关的安装指引：

1. [Docker runtime](https://docs.docker.com/engine/install/ubuntu/)
2. [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/).
3. [A Kubenetes cluster](https://minikube.sigs.k8s.io/docs/start/)
4. [Helm](https://helm.sh/docs/intro/install/)

## 使用

### 安装核心服务

1. 安装 Chart

```sh
git clone https://github.com/inf-monkeys/monkeys-cloud
cd monkeys-cloud/helm/charts/community/core

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add elastic https://helm.elastic.co
helm dependency build
helm install monkeys . --values ./values.yaml
```

2. 检查运行状态

```sh
kubectl get pods
kubectl get svc
```

3. 访问服务


默认情况下 `values.yaml` 使用 ClusterIP 模式, 你可以通过 **monkeys-proxy** service 访问 monkeys web ui:

```sh
# Get current pod list
kubectl get pods 

# Port Forward monkey-proxy-xxxx-xxxx Pod, in this example use local machine's 8080 port.
kubectl port-forward --address 0.0.0.0 monkey-proxy-xxxx-xxxx 8080:80

# Try
curl http://localhost:8080
```

如果你的服务运行在防火墙后面，请不要忘记打开防火墙。

### 安装 Monkey Tools

Monkey Tools 采用插件化设计，每个 monkey tool 有自己独立的 helm chart，你可以阅读对应的文档：

- [monkey-tools-vllm](./helm/charts/community/tools/monkey-tools-vllm/)
