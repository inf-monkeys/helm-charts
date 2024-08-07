<div align="center">

# Helm Chart for [monkey-tools-internet](https://github.com/inf-monkeys/monkey-tools-internet)<!-- omit in toc -->

</div>

中文 | [English](./README.md)

## 配置项

### 镜像版本

| 参数                        | 描述                          | 默认值                             |
| --------------------------- | ----------------------------- | ---------------------------------- |
| `images.server.registry`    | 镜像地址                      | `docker.io`                        |
| `images.server.repository`  | 镜像地址                      | `infmonkeys/monkey-tools-internet` |
| `images.server.tag`         | 版本号                        | `""`                               |
| `images.server.pullSecrets` | 拉取镜像的 secret，没有可留空 | `""`                               |
| `images.server.pullPolicy`  | 镜像拉取策略                  | `IfNotPresent`                     |

### Tavily API 配置

| 参数            | 描述           | 默认值 |
| --------------- | -------------- | ------ |
| `tavily.apikey` | Tavily Api Key | ``     |

### Jina.ai API 配置

| 参数            | 描述                                                                        | 默认值 |
| --------------- | --------------------------------------------------------------------------- | ------ |
| `jinaai.apikey` | Jina.ai Api Key, 可不填，Jina.ai 允许不适应 ApiKey 访问，但是会有频率限制。 | ``     |

### 代理配置

| 参数            | 描述           | 默认值  |
| --------------- | -------------- | ------- |
| `proxy.enabled` | 是否开启代理。 | `false` |
| `proxy.url`     | 代理地址       | `""`    |

## 安装

1. 安装 chart

```sh
helm install monkey-tools-internet . --values ./values.yaml -n monkeys
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
helm upgrade monkey-tools-internet . --namespace monkeys --values ./values.yaml --values ./prod-values.yaml
```

## 卸载

```sh
helm uninstall monkey-tools-internet -n monkeys
```
