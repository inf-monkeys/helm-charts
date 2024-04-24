<div align="center">

# Helm Chart for [monkey-tools-knowledge-base](https://github.com/inf-monkeys/monkey-tools-knowledge-base)<!-- omit in toc -->

</div>

- [下载 embedding 模型（可选）](#下载-embedding-模型可选)
- [配置项](#配置项)
  - [镜像版本](#镜像版本)
  - [Embedding 模型列表](#embedding-模型列表)
  - [配置向量数据库](#配置向量数据库)
    - [选择向量数据库类型](#选择向量数据库类型)
    - [配置 ES8 向量数据库](#配置-es8-向量数据库)
  - [配置业务数据库连接信息](#配置业务数据库连接信息)
  - [配置 Redis 连接信息](#配置-redis-连接信息)
- [安装](#安装)
  - [更新配置](#更新配置)
- [卸载](#卸载)


## 下载 embedding 模型（可选）

monkey-tools-knowledge-base 使用[FlagEmbedding](https://github.com/FlagOpen/FlagEmbedding) 来生成向量，在有网环境下，可以从 huggingface 拉取对应模型。如果你的环境处于无网环境，或者想减少初次拉取模型的时间消耗，可以提前下载好模型，并挂载到容器中。

以下是我们提供的可快速下载的模型列表以及 CDN 地址：

- BAAI/bge-base-zh-v1.5: 
    - 描述: 适用于中文语料的 embedding
    - huggingface repo: https://huggingface.co/BAAI/bge-base-zh-v1.5
    - CDN 下载地址: https://static.infmonkeys.com/models/embeddings/bge-base-zh-v1.5.tar.gz

- jinaai/jina-embeddings-v2-base-en:
    - 描述: 适用于英文语料的 embedding
    - huggingface repo: https://huggingface.co/jinaai/jina-embeddings-v2-base-en
    - CDN 下载地址: https://static.infmonkeys.com/models/embeddings/jina-embeddings-v2-base-en.tar.gz

- jinaai/jina-embeddings-v2-small-en:
    - 描述: 适用于英文语料的 embedding
    - huggingface repo: https://huggingface.co/jinaai/jina-embeddings-v2-small-en
    - CDN 下载地址: https://static.infmonkeys.com/models/embeddings/jina-embeddings-v2-small-en.tar.gz

- moka-ai/m3e-base:
    - 描述: 适用于中文语料的 embedding
    - huggingface repo: https://huggingface.co/moka-ai/m3e-base
    - CDN 下载地址: https://static.infmonkeys.com/models/embeddings/jina-embeddings-v2-small-en.tar.gz

下载之后，你需要解压到容器的 `/app/models` 目录下，并在配置文件中指定这些模型，详情请见下文。


## 配置项

### 镜像版本

| 参数                        | 描述                          | 默认值                                   |
| --------------------------- | ----------------------------- | ---------------------------------------- |
| `images.server.repository`  | 镜像地址                      | `infmonkeys/monkey-tools-knowledge-base` |
| `images.server.tag`         | 版本号                        | `""`                                     |
| `images.server.pullSecrets` | 拉取镜像的 secret，没有可留空 | `""`                                     |
| `images.server.pullPolicy`  | 镜像拉取策略                  | `IfNotPresent`                           |

### Embedding 模型列表


| 参数                                     | 描述                                                                                                                                                                                                                                                                                                          | 默认值 |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| `server.embeddings.models`               | Embedding 模型列表                                                                                                                                                                                                                                                                                            | `[]`   |
| `server.embeddings.models[].name`        | 模型名称，如 BAAI/bge-base-zh-v1.5，请务必填写完整。                                                                                                                                                                                                                                                          | `""`   |
| `server.embeddings.models[].displayName` | 模型显示名称，用于前端展示，默认和 `name` 保持一致。                                                                                                                                                                                                                                                          |        |
| `server.embeddings.models[].dimension`   | 向量纬度。                                                                                                                                                                                                                                                                                                    | `""`   |
| `server.embeddings.models[].modelPath`   | 模型所在路径，默认为 `/app/models/xxxxxx`，如模型的 `name` 为 `BAAI/bge-base-zh-v1.5`，则默认路径为 `/app/models/bge-base-zh-v1.5`；`name` 为 `jinaai/jina-embeddings-v2-small-en`，则默认路径为 `/app/models/jina-embeddings-v2-small-en`。在有网环境下，如果此路径不存在，则会从 huggingface 动态拉取模型。 | `""`   |


以下是一个完整的示例：

```yaml
server:
  embeddings:
    models:
      - name: BAAI/bge-base-zh-v1.5
        dimension: 768
      - name: jinaai/jina-embeddings-v2-base-en
        dimension: 768
      - name: jinaai/jina-embeddings-v2-small-en
        dimension: 512
      - name: moka-ai/m3e-base
        dimension: 768
        modelPath: /path/to/model/path
```

### 配置向量数据库

#### 选择向量数据库类型

| 参数                         | 描述                                       | 默认值          |
| ---------------------------- | ------------------------------------------ | --------------- |
| `server.storage.vector.type` | 向量数据库类型，目前只支持 `elasticsearch` | `elasticsearch` |


#### 配置 ES8 向量数据库

ES 从版本 8 开始支持向量，要求大版本号必须大于等于 8。

| 参数                             | 描述                                            | 默认值 |
| -------------------------------- | ----------------------------------------------- | ------ |
| `externalElasticsearch.url`      | 连接地址，如 `http://elasticsearch-master:9200` | `""`   |
| `externalElasticsearch.username` | 用户名                                          | `""`   |
| `externalElasticsearch.password` | 密码                                            | `""`   |


### 配置业务数据库连接信息

| 参数                                   | 描述                                                                           | 默认值 |
| -------------------------------------- | ------------------------------------------------------------------------------ | ------ |
| `externalPostgresql.url`               | 连接地址，如 `postgresql://monkeys:monkeys123@monkeys-postgresql:5432/monkeys` | `""`   |
| `externalPostgresql.pool.pool_size`    | 数据库连接池大小                                                               | `30`   |
| `externalPostgresql.pool.pool_recycle` | 数据库连接池回收时间，单位为毫秒                                               | `3600` |

### 配置 Redis 连接信息

此服务使用 redis 订阅模式异步消费任务。

| 参数                | 描述               | 默认值 |
| ------------------- | ------------------ | ------ |
| `externalRedis.url` | Redis 的连接地址。 | `""`   |

## 安装

1. 安装 chart

```sh
helm install monkey-tools-knowledge-base . --values ./values.yaml -n monkeys
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
helm upgrade monkey-tools-knowledge-base . --namespace monkeys --values ./values.yaml --values ./prod-values.yaml
```

## 卸载

```sh
helm uninstall monkey-tools-knowledge-base
```
