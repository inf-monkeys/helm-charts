<div align="center">

# Monkeys Helm Chart 

[![License](https://img.shields.io/github/license/inf-monkeys/helm-charts)](http://www.apache.org/licenses/LICENSE-2.0)
[![GitHub stars](https://img.shields.io/github/stars/inf-monkeys/helm-charts?style=social&label=Star&maxAge=2592000)](https://GitHub.com/inf-monkeys/helm-charts/stargazers/)
[![GitHub forks](https://img.shields.io/github/forks/inf-monkeys/helm-charts?style=social&label=Fork&maxAge=2592000)](https://github.com/inf-monkeys/helm-charts)

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

- [核心服务 Helm Chart](./charts/core/README_zh.md)

### 安装 Monkey Tools

Monkey Tools 采用插件化设计，每个 monkey tool 有自己独立的 helm chart，你可以阅读对应的文档：

- [monkey-tools-knowledge-base](./charts/monkey-tools-knowledge-base/README_zh.md)
- [monkey-tools-sandbox](./charts/monkey-tools-sandbox/README_zh.md)
- [monkey-tools-BepiPred3.0-Predictor](./charts/monkey-tools-BepiPred3.0-Predictor/README_zh.md)
- [monkey-tools-midjourney](./charts/monkey-tools-midjourney/README_zh.md)
- [monkey-tools-comfyui](./charts/monkey-tools-comfyui/README_zh.md)
- [monkey-tools-internet](./charts/monkey-tools-internet/README_zh.md)
- [monkey-tools-social-media](./charts/monkey-tools-social-media/README_zh.md)


### 安装开源组件

- [vllm-openai](./charts/vllm/README_zh.md)
- [comfyui](./charts/comfyui/README_zh.md)
