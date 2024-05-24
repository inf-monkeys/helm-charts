<div align="center">

# Monkeys Helm Chart 

[![License](https://img.shields.io/github/license/inf-monkeys/monkeys-helm)](http://www.apache.org/licenses/LICENSE-2.0)
[![GitHub stars](https://img.shields.io/github/stars/inf-monkeys/monkeys-helm?style=social&label=Star&maxAge=2592000)](https://GitHub.com/inf-monkeys/monkeys-helm/stargazers/)
[![GitHub forks](https://img.shields.io/github/forks/inf-monkeys/monkeys-helm?style=social&label=Fork&maxAge=2592000)](https://github.com/inf-monkeys/monkeys-helm)

</div>

中文 | [English](./README.md)


## 描述

此项目为 [https://github.com/inf-monkeys/monkeys](https://github.com/inf-monkeys/monkeys) 提供的官方 helm chart。

## 依赖

请确保你的服务器上已经安装了以下依赖，如果没有，你可以阅读相关的安装指引：

1. [Docker runtime](https://docs.docker.com/engine/install/ubuntu/)
2. [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/).
3. [A Kubenetes cluster](https://minikube.sigs.k8s.io/docs/start/)
4. [Helm](https://helm.sh/docs/intro/install/)

> 你也可以通过 `./scripts/` 目录下的一键安装脚本进行安装。

## 使用

### 安装核心服务

1. 安装 Chart 依赖

```sh
git clone https://github.com/inf-monkeys/monkeys-cloud
cd monkeys-cloud/helm/charts/community/core

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add elastic https://helm.elastic.co
helm dependency build
```

2. 修改配置项

**请详细阅读配置项中的内容。**

完整配置项请见: [配置项列表](./CONFIGURATION_zh.md)

3. 安装 Chart

```sh
helm install monkeys --namespace monkeys . --values ./values.yaml --create-namespace
```

4. 检查运行状态

```sh
kubectl get pods -n monkeys
kubectl get svc -n monkeys
```

5. 访问服务


默认情况下 `values.yaml` 使用 ClusterIP 模式, 你可以通过 **monkeys-proxy** service 访问 monkeys web ui:

```sh
# Get current pod list
kubectl get pods -n monkeys

# Port Forward monkey-proxy-xxxx-xxxx Pod, in this example use local machine's 8080 port.
kubectl port-forward --address 0.0.0.0 monkey-proxy-xxxx-xxxx 8080:80 -n monkeys

# Try
curl http://localhost:8080
```

如果你的服务运行在防火墙后面，请不要忘记打开防火墙。

### 更新配置

创建一个新的 Values yaml 文件, 比如 `prod-values.yaml`。

比如说你需要更新 server 的镜像，添加下面的内容到 `prod-values.yaml` 中:

```yaml
images:
  server:
    tag: some-new-tag
```

然后执行：

```sh
helm upgrade monkeys .  --namespace monkeys --values ./values.yaml --values ./prod-values.yaml
```

### 安装 Monkey Tools

Monkey Tools 采用插件化设计，每个 monkey tool 有自己独立的 helm chart，你可以阅读对应的文档：

- [monkey-tools-knowledge-base](./helm/charts/community/tools/monkey-tools-knowledge-base/README_zh.md)
- [monkey-tools-sandbox](./helm/charts/community/tools/monkey-tools-sandbox/README_zh.md)
- [monkey-tools-BepiPred3.0-Predictor](./helm/charts/community/tools/monkey-tools-BepiPred3.0-Predictor/README_zh.md)
- [monkey-tools-midjourney](./helm/charts/community/tools/monkey-tools-midjourney/README_zh.md)
- [monkey-tools-comfyui](./helm/charts/community/tools/monkey-tools-comfyui/README_zh.md)
- [monkey-tools-internet](./helm/charts/community/tools/monkey-tools-internet/README_zh.md)


### 安装开源组件

- [vllm-openai](./helm/charts/community/opensource/vllm/README_zh.md)
