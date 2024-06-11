<div align="center">

# Helm Chart for [monkey-tools-social-media](https://github.com/inf-monkeys/monkey-tools-social-media)<!-- omit in toc -->

</div>

中文 | [English](./README.md)

## 配置项

### 镜像版本

| 参数                        | 描述                          | 默认值                                 |
| --------------------------- | ----------------------------- | -------------------------------------- |
| `images.server.repository`  | 镜像地址                      | `infmonkeys/monkey-tools-social-media` |
| `images.server.tag`         | 版本号                        | `""`                                   |
| `images.server.pullSecrets` | 拉取镜像的 secret，没有可留空 | `""`                                   |
| `images.server.pullPolicy`  | 镜像拉取策略                  | `IfNotPresent`                         |


### 代理配置

| 参数            | 描述           | 默认值  |
| --------------- | -------------- | ------- |
| `proxy.enabled` | 是否开启代理。 | `false` |
| `proxy.url`     | 代理地址       | `""`    |

## 安装

1. 安装 chart

```sh
helm install monkey-tools-social-media . --values ./values.yaml -n monkeys
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
helm upgrade monkey-tools-social-media . --namespace monkeys --values ./values.yaml --values ./prod-values.yaml
```

## 卸载

```sh
helm uninstall monkey-tools-social-media -n monkeys
```
