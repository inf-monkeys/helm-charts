<div align="center">

# Helm Chart for [vllm](https://github.com/vllm-project/vllm)<!-- omit in toc -->

</div>

中文 | [English](./README.md)

## K8S 集群配置 GPU 资源

VLLM 运行依赖 GPU 资源，如果你的 k8s 集群已经配置好了，可以跳过此部分。

- K8S 集群安装指引请见: [https://kubernetes.io/zh-cn/docs/tasks/manage-gpus/scheduling-gpus/](https://kubernetes.io/zh-cn/docs/tasks/manage-gpus/scheduling-gpus/)。
- Minikube 集群安装指引请见: [https://minikube.sigs.k8s.io/docs/tutorials/nvidia/](https://minikube.sigs.k8s.io/docs/tutorials/nvidia/)。

## 配置项

### 镜像版本

| 参数                      | 描述                          | 默认值             |
| ------------------------- | ----------------------------- | ------------------ |
| `images.vllm.repository`  | 镜像地址                      | `vllm/vllm-openai` |
| `images.vllm.tag`         | 版本号                        | `""`               |
| `images.vllm.pullSecrets` | 拉取镜像的 secret，没有可留空 | `""`               |
| `images.vllm.pullPolicy`  | 镜像拉取策略                  | `IfNotPresent`     |


### vllm 配置

| 参数                      | 描述                          | 默认值             |
| ------------------------- | ----------------------------- | ------------------ |
| `images.vllm.repository`  | 镜像地址                      | `vllm/vllm-openai` |
| `images.vllm.tag`         | 版本号                        | `""`               |
| `images.vllm.pullSecrets` | 拉取镜像的 secret，没有可留空 | `""`               |
| `images.vllm.pullPolicy`  | 镜像拉取策略                  | `IfNotPresent`     |


## 安装

1. 安装 chart

```sh
helm install vllm . --values ./values.yaml -n monkeys
```

2. 检查状态

```sh
kubectl get pods -n monkeys
kubectl get svc -n monkeys
```

### 更新配置

创建一个新的 Values yaml 文件, 比如 `prod-values.yaml`。

比如说你需要更新 sandbox 的镜像，添加下面的内容到 `prod-values.yaml` 中:

```yaml
images:
  server:
    tag: some-new-tag
```

然后执行：

```sh
helm upgrade vllm . --namespace monkeys --values ./values.yaml --values ./prod-values.yaml
```

## 卸载

```sh
helm uninstall vllm -n monkeys
```

## 常见问题

1. ValueError: The number of required GPUs exceeds the total number of available GPUs in the cluster.

是否在 `args` 中指定了 `--tensor-parallel-size`，大于 `limits` 中的 `nvidia.com/gpu`.

