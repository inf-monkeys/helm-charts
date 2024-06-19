<div align="center">

# Helm Chart for [monkey-tools-BepiPred3.0-Predictor](https://github.com/inf-monkeys/monkey-tools-BepiPred3.0-Predictor)<!-- omit in toc -->

</div>

中文 | [English](./README.md)

- [配置](#配置)
  - [外部 S3 存储](#外部-s3-存储)
- [安装](#安装)
  - [更新配置](#更新配置)
- [卸载](#卸载)


## 配置

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
helm install monkey-tools-bepipred30-predictor . --values ./values.yaml -n monkeys
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
  sandbox:
    tag: some-new-tag
```

然后执行：

```sh
helm upgrade monkey-tools-bepipred30-predictor . --namespace monkeys --values ./values.yaml --values ./prod-values.yaml
```

## 卸载

```sh
helm uninstall monkey-tools-bepipred30-predictor
```
