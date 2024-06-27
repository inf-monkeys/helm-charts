<div align="center">

# Helm Chart for [monkey-tools-knowledge-base](https://github.com/inf-monkeys/monkey-tools-knowledge-base)<!-- omit in toc -->

</div>

中文 | [English](./README.md)


- [基本信息](#基本信息)
- [安装](#安装)
  - [安装 Chart](#安装-chart)
  - [检查运行状态](#检查运行状态)
  - [导入工具](#导入工具)
  - [更新配置](#更新配置)
  - [卸载](#卸载)
- [下载 embedding 模型（可选）](#下载-embedding-模型可选)
- [配置项](#配置项)
  - [镜像版本](#镜像版本)
  - [Embedding 模型列表](#embedding-模型列表)
  - [配置业务数据库](#配置业务数据库)
  - [配置 Redis](#配置-redis)
    - [单机 Redis](#单机-redis)
    - [Redis 集群](#redis-集群)
      - [Redis sentinel](#redis-sentinel)
  - [配置向量数据库](#配置向量数据库)
    - [选项一：使用 ES8 作为向量数据库](#选项一使用-es8-作为向量数据库)
    - [选项二：使用 PGVector 作为向量数据库](#选项二使用-pgvector-作为向量数据库)
  - [Configure Business Database](#configure-business-database)
  - [Configure Redis](#configure-redis)
    - [Standalone Redis](#standalone-redis)
    - [Redis Cluster](#redis-cluster)
      - [Redis Sentinel](#redis-sentinel-1)
  - [Configure Vector Database](#configure-vector-database)
    - [Option 1: Using ES8 as Vector Database](#option-1-using-es8-as-vector-database)
    - [Option 2: Using PGVector as Vector Database](#option-2-using-pgvector-as-vector-database)

## 基本信息

此工具的 `manifestUrl` 地址为：`http://monkey-tools-knowledge-base:5000/manifest.json`。

## 安装

### 安装 Chart

```sh
# 添加 Chart 依赖
helm repo add monkeys https://inf-monkeys.github.io/helm-charts

# 安装核心服务
helm install monkey-tools-knowledge-base monkeys/monkey-tools-knowledge-base -n monkeys --create-namespace
```

<details>
<summary><kbd>开发模式</kbd></summary>

Helm Chart 的开发者可以使用下面的命令在本地进行安装：

```sh
cd charts/monkey-tools-knowledge-base
helm install monkey-tools-knowledge-base . --values ./values.yaml -n monkeys --create-namespace
```

</details>

### 检查运行状态

```sh
kubectl get pods -n monkeys
kubectl get svc -n monkeys
```

### 导入工具

一共有两种导入工具的方式：

1. 通过 `core` 服务的配置文件导入：通过此种方式导入的工具为全局工具，所有团队都可以直接使用。详情请见 [预制工具](../core/README_zh.md#预制工具)。
2. 在控制台页面种手动导入：通过这种方式导入的工具只对当前团队有效。详情请见 [https://inf-monkeys.github.io/docs/zh-cn/tools/use-custom-tools](https://inf-monkeys.github.io/docs/zh-cn/tools/use-custom-tools)。


### 更新配置

创建一个新的 Values yaml 文件, 比如 `prod-core-values.yaml`。

比如说你需要更新 server 的镜像，添加下面的内容到 `prod-core-values.yaml` 中:

```yaml
images:
  server:
    tag: some-new-tag
```

然后执行：

```sh
helm upgrade monkey-tools-knowledge-base .  --namespace monkeys --values ./prod-core-values.yaml
```

### 卸载

```sh
helm uninstall monkey-tools-knowledge-base -n monkeys
```


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
| `images.server.registry`    | 镜像仓库                      | `docker.io`                              |
| `images.server.repository`  | 镜像地址                      | `infmonkeys/monkey-tools-knowledge-base` |
| `images.server.tag`         | 版本号                        | `""`                                     |
| `images.server.pullSecrets` | 拉取镜像的 secret，没有可留空 | `""`                                     |
| `images.server.pullPolicy`  | 镜像拉取策略                  | `IfNotPresent`                           |

### Embedding 模型列表


| 参数                                            | 描述                                                                                                                                                                                                                                                                                                                                           | 默认值    |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| `embeddingsModels`                              | Embedding 模型列表                                                                                                                                                                                                                                                                                                                             | `[]`      |
| `embeddingsModels[].type`                       | 模型类型，分为 `local`（本地模型）和 `api`（使用自定义 API 接口。）                                                                                                                                                                                                                                                                            | `"local"` |
| `embeddingsModels[].name`                       | 模型名称，如 BAAI/bge-base-zh-v1.5，请务必填写完整。                                                                                                                                                                                                                                                                                           | `""`      |
| `embeddingsModels[].displayName`                | 模型显示名称，用于前端展示，默认和 `name` 保持一致。                                                                                                                                                                                                                                                                                           |           |
| `embeddingsModels[].dimension`                  | 向量纬度。                                                                                                                                                                                                                                                                                                                                     | `""`      |
| `embeddingsModels[].modelPath`                  | 只当 `type` 为 `local` 时才生效。模型所在路径，默认为 `/app/models/xxxxxx`，如模型的 `name` 为 `BAAI/bge-base-zh-v1.5`，则默认路径为 `/app/models/bge-base-zh-v1.5`；`name` 为 `jinaai/jina-embeddings-v2-small-en`，则默认路径为 `/app/models/jina-embeddings-v2-small-en`。在有网环境下，如果此路径不存在，则会从 huggingface 动态拉取模型。 | `""`      |
| `embeddingsModels.apiConfig.url`                | 只当 `type` 为 `api` 时才生效。自定义 embedding 服务的请求地址。                                                                                                                                                                                                                                                                               | `""`      |
| `embeddingsModels[].apiConfig.method`           | 只当 `type` 为 `api` 时才生效。自定义 embedding 服务的 HTTP 请求方式。                                                                                                                                                                                                                                                                         | `"POST"`  |
| `embeddingsModels[].apiConfig.headers`          | 只当 `type` 为 `api` 时才生效。自定义 embedding 服务的 HTTP 请求头。                                                                                                                                                                                                                                                                           | `""`      |
| `embeddingsModels[].apiConfig.body`             | 只当 `type` 为 `api` 时才生效。自定义 embedding 服务的 HTTP 请求体。                                                                                                                                                                                                                                                                           | `""`      |
| `embeddingsModels[].apiConfig.responseResolver` | 只当 `type` 为 `api` 时才生效。自定义 embedding 服务的数据解析方式。                                                                                                                                                                                                                                                                           | `""`      |

以下是一个完整的示例：

```yaml
embeddingsModels:
  - name: BAAI/bge-base-zh-v1.5
    dimension: 768
  - name: jinaai/jina-embeddings-v2-base-en
    dimension: 768
  - name: jinaai/jina-embeddings-v2-small-en
    dimension: 512
  - name: moka-ai/m3e-base
    dimension: 768
    modelPath: /path/to/model/path

  - name: daocloud
    displayName: daocloud
    dimension: 1024
    type: api
    apiConfig:
      url: http://localhost:5200/embeddings/FileVectorize
      method: POST
      headers:
        Content-Type: application/json
        Authorization: Bearer token
      body:
        shard: "{documents}"
      responseResolver:
        type: json
        path: embeddings
```


### 配置业务数据库

> 此数据库用于存储业务数据（非向量数据），不要求开启 pgvector。

| 参数                                   | 描述                                                                           | 默认值 |
| -------------------------------------- | ------------------------------------------------------------------------------ | ------ |
| `externalPostgresql.url`               | 连接地址，如 `postgresql://monkeys:monkeys123@monkeys-postgresql:5432/monkeys` | `""`   |
| `externalPostgresql.pool.pool_size`    | 数据库连接池大小                                                               | `30`   |
| `externalPostgresql.pool.pool_recycle` | 数据库连接池回收时间，单位为毫秒                                               | `3600` |

### 配置 Redis

此服务使用 redis 订阅模式异步消费任务。

#### 单机 Redis

| 参数                 | 描述                                                                                                 | 默认值         |
| -------------------- | ---------------------------------------------------------------------------------------------------- | -------------- |
| `externalRedis.mode` | Redis 部署架构                                                                                       | `"standalone"` |
| `externalRedis.url`  | Redis 连接地址，如 `redis://@localhost:6379/0`，包含密码的示例: `redis://:password@localhost:6379/0` | `""`           |

#### Redis 集群

| 参数                     | 描述               | 默认值    |
| ------------------------ | ------------------ | --------- |
| `externalRedis.mode`     | Redis 部署架构     | `cluster` |
| `externalRedis.nodes`    | Redis 集群节点列表 | `""`      |
| `externalRedis.password` | 密码               | `""`      |

Redis 集群节点列表示例：

```yaml
nodes:
  - host: 127.0.0.1
    port: 7001
  - host: 127.0.0.1
    port: 7002
  - host: 127.0.0.1
    port: 7003
  - host: 127.0.0.1
    port: 7004
  - host: 127.0.0.1
    port: 7005
  - host: 127.0.0.1
    port: 7006
```

##### Redis sentinel

| 参数                         | 描述                | 默认值     |
| ---------------------------- | ------------------- | ---------- |
| `externalRedis.mode`         | Redis 部署架构      | `sentinel` |
| `externalRedis.sentinels`    | Redis 哨兵节点列表  | `""`       |
| `externalRedis.sentinelName` | Redis sentinel Name | `""`       |
| `externalRedis.password`     | 密码                | `""`       |

Redis 哨兵节点列表示例：

```yaml
sentinels:
  - host: 127.0.0.1
    port: 7101
```


### 配置向量数据库

#### 选项一：使用 ES8 作为向量数据库

ES 从版本 8 开始支持向量，要求大版本号必须大于等于 8。

| 参数                                        | 描述                                             | 默认值  |
| ------------------------------------------- | ------------------------------------------------ | ------- |
| `externalElasticsearchVectorStore.enabled`  | 如果使用 ES8 作为向量数据库，需要设置为 `true`。 | `false` |
| `externalElasticsearchVectorStore.url`      | 连接地址，如 `http://elasticsearch-master:9200`  | `""`    |
| `externalElasticsearchVectorStore.username` | 用户名                                           | `""`    |
| `externalElasticsearchVectorStore.password` | 密码                                             | `""`    |


#### 选项二：使用 PGVector 作为向量数据库

需要在 postgres 数据库之上安装 pgvector 扩展，详情请见文档 [https://github.com/pgvector/pgvector](https://github.com/pgvector/pgvector)。


| 参数                            | 描述                                                                 | 默认值    |
| ------------------------------- | -------------------------------------------------------------------- | --------- |
| `externalPGVectorStore.enabled` | 如果使用 PGVector 作为向量数据库，需要设置为 `true`。                | `"false"` |
| `externalPGVectorStore.url`     | 连接地址，如 `postgresql://postgres:postgres@localhost:5432/monkeys` | `""`      |

### Configure Business Database

> This database is used to store business data (non-vector data) and does not require pgvector to be enabled.

| Parameter                             | Description                                                                                 | Default |
| ------------------------------------- | ------------------------------------------------------------------------------------------- | ------- |
| `externalPostgresql.url`              | Connection URL, e.g., `postgresql://monkeys:monkeys123@monkeys-postgresql:5432/monkeys`     | `""`    |
| `externalPostgresql.pool.pool_size`   | Database connection pool size                                                               | `30`    |
| `externalPostgresql.pool.pool_recycle`| Database connection pool recycle time, in milliseconds                                      | `3600`  |

### Configure Redis

This service uses Redis subscription mode to asynchronously consume tasks.

#### Standalone Redis

| Parameter              | Description                                                                                                 | Default         |
| ---------------------- | ----------------------------------------------------------------------------------------------------------- | --------------  |
| `externalRedis.mode`   | Redis deployment architecture                                                                               | `"standalone"`  |
| `externalRedis.url`    | Redis connection URL, e.g., `redis://@localhost:6379/0`. Example with password: `redis://:password@localhost:6379/0` | `""`            |

#### Redis Cluster

| Parameter                 | Description             | Default  |
| ------------------------- | ----------------------- | -------- |
| `externalRedis.mode`      | Redis deployment architecture     | `cluster` |
| `externalRedis.nodes`     | Redis cluster node list  | `""`     |
| `externalRedis.password`  | Password                 | `""`     |

Example of Redis cluster node list:

```yaml
nodes:
  - host: 127.0.0.1
    port: 7001
  - host: 127.0.0.1
    port: 7002
  - host: 127.0.0.1
    port: 7003
  - host: 127.0.0.1
    port: 7004
  - host: 127.0.0.1
    port: 7005
  - host: 127.0.0.1
    port: 7006
```

##### Redis Sentinel

| Parameter                      | Description             | Default     |
| ------------------------------ | ----------------------- | ----------- |
| `externalRedis.mode`           | Redis deployment architecture      | `sentinel`  |
| `externalRedis.sentinels`      | Redis sentinel node list | `""`        |
| `externalRedis.sentinelName`   | Redis sentinel name      | `""`        |
| `externalRedis.password`       | Password                 | `""`        |

Example of Redis sentinel node list:

```yaml
sentinels:
  - host: 127.0.0.1
    port: 7101
```

### Configure Vector Database

#### Option 1: Using ES8 as Vector Database

Elasticsearch supports vectors from version 8 onwards. The major version must be 8 or higher.

| Parameter                                | Description                                           | Default  |
| ---------------------------------------- | ----------------------------------------------------- | -------  |
| `externalElasticsearchVectorStore.enabled` | If using ES8 as the vector database, set to `true`.  | `false`  |
| `externalElasticsearchVectorStore.url`    | Connection URL, e.g., `http://elasticsearch-master:9200` | `""`     |
| `externalElasticsearchVectorStore.username`| Username                                              | `""`     |
| `externalElasticsearchVectorStore.password`| Password                                              | `""`     |

#### Option 2: Using PGVector as Vector Database

You need to install the pgvector extension on the PostgreSQL database. For details, please refer to the documentation [https://github.com/pgvector/pgvector](https://github.com/pgvector/pgvector).

| Parameter                         | Description                                                           | Default    |
| --------------------------------- | --------------------------------------------------------------------- | ---------- |
| `externalPGVectorStore.enabled`   | If using PGVector as the vector database, set to `true`.              | `"false"`  |
| `externalPGVectorStore.url`       | Connection URL, e.g., `postgresql://postgres:postgres@localhost:5432/monkeys` | `""`      |