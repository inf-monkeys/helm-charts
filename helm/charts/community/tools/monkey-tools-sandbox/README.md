# Helm Chart for https://github.com/inf-monkeys/monkey-tools-sandbox

**THIS TOOL REQUIRES CUDA environment, besure your machine has CUDA installed.**

## Configuration

Note the following configuraions which may be important:

1. vllmServer.Replicas
2. vllmServer.resources: [vllm](https://github.com/vllm-project/vllm) [requires CUDA environment](https://docs.vllm.ai/en/latest/getting_started/installation.html), you can modify nvidia.com/gpu as you need.
3. vllmServer.extraEnv: adjust CUDA_VISIBLE_DEVICES as you need.

## Install

1. Install the chart

```sh
helm install monkey-tools-sandbox . --values ./values.yaml
```

2. Check status

```sh
kubectl get pods
kubectl get svc
```

## Uninstall

```
helm uninstall monkey-tools-sandbox
```