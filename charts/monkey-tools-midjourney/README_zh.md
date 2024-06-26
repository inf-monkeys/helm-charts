<div align="center">

# Helm Chart for [monkey-tools-midjourney](https://github.com/inf-monkeys/monkey-tools-midjourney)<!-- omit in toc -->

</div>

中文 | [English](./README.md)

## 配置项

### 镜像版本

| 参数                        | 描述                          | 默认值                               |
| --------------------------- | ----------------------------- | ------------------------------------ |
| `images.server.repository`  | 镜像地址                      | `infmonkeys/monkey-tools-midjourney` |
| `images.server.tag`         | 版本号                        | `""`                                 |
| `images.server.pullSecrets` | 拉取镜像的 secret，没有可留空 | `""`                                 |
| `images.server.pullPolicy`  | 镜像拉取策略                  | `IfNotPresent`                       |

### GoAPI Key


目前仅支持 [GoAPI](https://www.goapi.ai/midjourney-api) 提供的 Midjourney 服务，需要配置 GoAPI apikey：

| 参数           | 描述                                                 | 默认值 |
| -------------- | ---------------------------------------------------- | ------ |
| `goapi.apikey` | [GoAPI](https://www.goapi.ai/midjourney-api) Api Key | `""`   |
| `""`           |

### 外部 S3 存储

> 此工具需要将蛋白质免疫原性预测的结果（文件）上传 S3，以供外部使用。

| 参数                         | 描述                                                                                                | 默认值  |
| ---------------------------- | --------------------------------------------------------------------------------------------------- | ------- |
| `externalS3.forcePathStyle`  | 是否使用 path-style endpoint, 当你使用 minio 时，一般都需要设置为 `true`                            | `false` |
| `externalS3.endpoint`        | 访问地址                                                                                            | `""`    |
| `externalS3.accessKeyId`     | AccessKeyID                                                                                         | `""`    |
| `externalS3.secretAccessKey` | Secret Access Key                                                                                   | `""`    |
| `externalS3.region`          | 区域                                                                                                | `""`    |
| `externalS3.bucket`          | Bucket 名称，请使用公开的 bucket，以便前端能够访问到。                                              | `""`    |
| `externalS3.publicAccessUrl` | 请填写外部（浏览器）可访问的地址，一般为 Bucket 配置的 CDN 地址，如 `https://static.infmonkeys.com` | `31900` |

## 安装

1. 安装 chart

```sh
helm install monkey-tools-midjourney . --values ./values.yaml -n monkeys
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
helm upgrade monkey-tools-midjourney . --namespace monkeys --values ./values.yaml --values ./prod-values.yaml
```

## 卸载

```sh
helm uninstall monkey-tools-midjourney
```
