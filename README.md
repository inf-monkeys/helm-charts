<div align="center">

# Helm Chart for Monkeys

[![License](https://img.shields.io/github/license/inf-monkeys/helm-charts)](http://www.apache.org/licenses/LICENSE-2.0)
[![GitHub stars](https://img.shields.io/github/stars/inf-monkeys/helm-chart?style=social&label=Star&maxAge=2592000)](https://GitHub.com/inf-monkeys/helm-charts/stargazers/)
[![GitHub forks](https://img.shields.io/github/forks/inf-monkeys/helm-charts?style=social&label=Fork&maxAge=2592000)](https://github.com/inf-monkeys/helm-charts)

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
