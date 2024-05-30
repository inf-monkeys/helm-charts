<div align="center">

# Helm Chart for [comfyui](https://github.com/inf-monkeys/Comfyfile)<!-- omit in toc -->

</div>

中文 | [English](./README.md)

## K8S 集群配置 GPU 资源

comfyui 运行依赖 GPU 资源，如果你的 k8s 集群已经配置好了，可以跳过此部分。

- K8S 集群安装指引请见: [https://kubernetes.io/zh-cn/docs/tasks/manage-gpus/scheduling-gpus/](https://kubernetes.io/zh-cn/docs/tasks/manage-gpus/scheduling-gpus/)。
- Minikube 集群安装指引请见: [https://minikube.sigs.k8s.io/docs/tutorials/nvidia/](https://minikube.sigs.k8s.io/docs/tutorials/nvidia/)。

## 配置项

### 镜像版本

| 参数                         | 描述                          | 默认值               |
| ---------------------------- | ----------------------------- | -------------------- |
| `images.comfyui.repository`  | 镜像地址                      | `infmonkeys/comfyui` |
| `images.comfyui.tag`         | 版本号                        | `"0.0.2-gpu"`        |
| `images.comfyui.pullSecrets` | 拉取镜像的 secret，没有可留空 | `""`                 |
| `images.comfyui.pullPolicy`  | 镜像拉取策略                  | `IfNotPresent`       |


### comfyui 配置

#### 代理

##### 使用外部代理

| 参数              | 描述                                                               | 默认值 |
| ----------------- | ------------------------------------------------------------------ | ------ |
| `env.http_proxy`  | 填写 proxy 地址，使用外置的 http proxy。如 `http://127.0.0.1:7890` | `""`   |
| `env.https_proxy` | 填写 proxy 地址，使用外置的 http proxy。如 `http://127.0.0.1:7890` | `""`   |

##### 使用内部代理

| 参数                         | 描述             | 默认值 |
| ---------------------------- | ---------------- | ------ |
| `env.CLASH_SUBSCRIPTION_URL` | Clash 的订阅地址 |
| `env.CLASH_SECRET`           | 没有可不填。     |


#### S3 对象存储

| 参数                       | 描述                                                     | 默认值   |
| -------------------------- | -------------------------------------------------------- | -------- |
| `env.S3_ENABLED`           | 是否开启 S3。                                            | `"true"` |
| `env.S3_ENDPOINT_URL`      | S3 访问地址。                                            | `""`     |
| `env.S3_ACCESS_KEY_ID`     | AccessKeyID                                              | ``       |
| `env.S3_SECRET_ACCESS_KEY` | Secret Access Key                                        | ``       |
| `env.S3_REGION`            | 区域, minio 填 `us-esat-1`                               | ``       |
| `env.S3_BUCKET`            | Bucket 名称，请使用公开的 bucket，以便前端能够访问到。   | ``       |
| `env.S3_PUBLIC_ACCESS_URL` | Bucket 名称，请使用公开的 bucket，以便前端能够访问到。   | ``       |
| `env.S3_ADDRESSING_STYLE`  | Addressing style，可选值为 `path`, `virtual` 和 `auto`。 | `auto`   |

#### 其他

| 参数                         | 描述                                                                                                                                            | 默认值    |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `env.AUTO_UPGRADE_COMFYFILE` | 是否自动更新 https://github.com/inf-monkeys/Comfyfile 插件，这样当 comfyfile 更新时不需要重新构建镜像，但是这要求运行环境有网络且能访问 github. | `"false"` |

#### PVCs

你需要提前创建好 5 个 PVCs:

> 如果不挂载 pvc 会导致容器重启时历史数据（模型、节点、Python 依赖、输入输出文件等）丢失。

- `comfyui-models`: 用于存储模型文件。
- `comfyui-custom-nodes`: 用于存储自定义节点。
- `comfyui-input`: 用于存储输入文件。
- `comfyui-output`: 用于存储输出文件。
- `comfyui-venv`: 用于存储 Python 依赖。
- `comfyui-huggingface`: 用于存储 huggingface 的模型。

你可以在 `values.yaml` 中的 `volume` 修改对应的 `claimName`。

## 安装

1. 安装 chart

```sh
helm install comfyui . --values ./values.yaml -n monkeys
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
helm upgrade comfyui . --namespace monkeys --values ./values.yaml --values ./prod-values.yaml
```

## 卸载

```sh
helm uninstall comfyui -n monkeys
```
