<div align="center">

# 配置项说明文档<!-- omit in toc -->

</div>

- [业务配置](#业务配置)
- [中间件配置](#中间件配置)
  - [Postgres 数据库](#postgres-数据库)
    - [使用内置数据库](#使用内置数据库)
    - [使用外置数据库](#使用外置数据库)
      - [Monkeys 业务数据库](#monkeys-业务数据库)
      - [Conductor 数据库](#conductor-数据库)
  - [Elasticsearch 7](#elasticsearch-7)
    - [使用内置 Elasticsearch 7](#使用内置-elasticsearch-7)
    - [使用外置 Elasticsearch 7](#使用外置-elasticsearch-7)
  - [Redis](#redis)
    - [使用内置 Redis](#使用内置-redis)
    - [使用外置 Redis](#使用外置-redis)
      - [单机 Redis](#单机-redis)
      - [Redis 集群](#redis-集群)
        - [Redis sentinel](#redis-sentinel)
  - [MinIO(S3) 存储](#minios3-存储)
    - [使用内置 Minio 存储](#使用内置-minio-存储)
    - [使用外部 S3 存储](#使用外部-s3-存储)
- [服务配置](#服务配置)
  - [ClusterIP 模式示例](#clusterip-模式示例)
  - [NodePort 模式示例](#nodeport-模式示例)
- [语言模型配置项说明](#语言模型配置项说明)


## 业务配置

| 参数                                                     | 描述                                                                                             | 默认值                                             |
| -------------------------------------------------------- | ------------------------------------------------------------------------------------------------ | -------------------------------------------------- |
| `images.server.repository`                               | [monkeys](https://github.com/inf-monkeys/monkeys) 服务 Docker 镜像地址                           | `infmonkeys/monkeys`                               |
| `images.server.tag`                                      | 版本号号                                                                                         |                                                    |
| `images.server.pullPolicy`                               | 镜像拉取策略                                                                                     | `IfNotPresent`                                     |
| `images.web.repository`                                  | [前端](https://github.com/inf-monkeys/monkeys/tree/main/ui) Docker 镜像地址                      | `infmonkeys/monkeys-ui`                            |
| `images.web.tag`                                         | 版本号                                                                                           |                                                    |
| `images.web.pullPolicy`                                  | 镜像拉取策略                                                                                     |
| `images.conductor.repository`                            | 流程编排引擎 [conductor](https://github.com/inf-monkeys/conductor) 的镜像地址                    | `infmonkeys/conductor`                             |
| `images.conductor.tag`                                   | 版本号                                                                                           | `1.0.0`                                            |
| `proxy.enabled`                                          | 是否使用 nginx 作为反向代理，用于同一前后端域名，根据路径转发到对应的服务。                      | `true`                                             |
| `proxy.replicas`                                         | 副本数                                                                                           | `1`                                                |
| `server.replicas`                                        | 副本数                                                                                           | `1`                                                |
| `server.server.appId`                                    | 此次部署服务的唯一 ID，将会作为数据库表、redis key 的前缀。                                      | `monkeys`                                          |
| `server.server.appUrl`                                   | 对外可访问的连接，此配置项会影响到 OIDC 单点登录跳转以及自定义触发器，除此之外不会影响其他功能。 | `http://localhost:3000`                            |
| `server.server.customization.title`                      | 网站标题。                                                                                       | `猴子无限`                                         |
| `server.server.customization.logoUrl`                    | 左上角 Logo 图标。                                                                               | `https://static.aside.fun/static/vines.svg`        |
| `server.server.customization.faviconUrl`                 | 浏览器 Favicon 图标                                                                              | `https://static.infmonkeys.com/upload/favicon.svg` |
| `server.server.customization.colors.primary`             | 主颜色                                                                                           | `#52ad1f`                                          |
| `server.server.customization.colors.secondary`           | Secondary 颜色                                                                                   | `#16161a`                                          |
| `server.server.customization.colors.secondaryBackground` | Secondary 背景颜色                                                                               | `#212121`                                          |
| `server.auth.enabled`                                    | 启用的认证方式，默认只启用密码登录和 APIKey 接口认证。                                           | `password,apikey`                                  |
| `server.models`                                          | 启用的语言模型，详细配置请见[语言模型配置项说明](#语言模型配置项说明)                            | `[]`                                               |
| `web.replicas`                                           | 前端副本数                                                                                       | `1`                                                |
| `conductor.replicas`                                     | Conductor 副本数                                                                                 | `1`                                                |

## 中间件配置

### Postgres 数据库

#### 使用内置数据库

| 参数                                                 | 描述                                                                                                                              | 默认值       |
| ---------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | ------------ |
| `postgresql.enabled`                                 | 是否启用内置数据库。如果设置为 true，将会创建一个新的 postgresql 实例（不保证高可用），如果你有其他现成的数据库，请设置为 false。 | `true`       |
| `postgresql.global.postgresql.auth.postgresPassword` | Postgres 用户密码                                                                                                                 | `monkeys123` |
| `postgresql.global.postgresql.auth.username`         | 创建的用户名                                                                                                                      | `monkeys`    |
| `postgresql.global.postgresql.auth.password`         | 创建用户的密码                                                                                                                    | `monkeys123` |
| `postgresql.global.postgresql.auth.database`         | 创建的 database                                                                                                                   | `monkeys`    |


#### 使用外置数据库

> monkeys-server 和 conductor 均需要使用 PG 数据库，建议分配不同的 database。

##### Monkeys 业务数据库

| 参数                          | 描述                 | 默认值  |
| ----------------------------- | -------------------- | ------- |
| `externalPostgresql.enabled`  | 是否使用外置的数据库 | `false` |
| `externalPostgresql.host`     | 域名或者 ip          | `""`    |
| `externalPostgresql.port`     | 端口                 | `5432`  |
| `externalPostgresql.username` | 用户名               | `""`    |
| `externalPostgresql.password` | 密码                 | `""`    |
| `externalPostgresql.database` | database             | `""`    |

##### Conductor 数据库

| 参数                                   | 描述                 | 默认值  |
| -------------------------------------- | -------------------- | ------- |
| `externalConductorPostgresql.enabled`  | 是否使用外置的数据库 | `false` |
| `externalConductorPostgresql.host`     | 域名或者 ip          | `""`    |
| `externalConductorPostgresql.port`     | 端口                 | `5432`  |
| `externalConductorPostgresql.username` | 用户名               | `""`    |
| `externalConductorPostgresql.password` | 密码                 | `""`    |
| `externalConductorPostgresql.database` | database             | `""`    |


### Elasticsearch 7 

我们会用 ES7 存储 Conductor 工作流的执行数据。

#### 使用内置 Elasticsearch 7


| 参数                               | 描述                                                                                                                                                       | 默认值                                          |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| `elasticsearch.enabled`            | 是否启用内置的 Elasticsearch。如果设置为 true，将会创建一个新的 elasticsearch 7 实例（不保证高可用），如果你有其他现成的 elasticsearch 7，请设置为 false。 | `true`                                          |
| `elasticsearch.replicas`           | 副本数                                                                                                                                                     | `1`                                             |
| `elasticsearch.image`              | 镜像地址                                                                                                                                                   | `docker.elastic.co/elasticsearch/elasticsearch` |
| `elasticsearch.imageTag`           | 版本号，大版本号必须为 7                                                                                                                                   | `7.17.3`                                        |
| `elasticsearch.minimumMasterNodes` | 最小 master 节点数                                                                                                                                         | `1`                                             |
| `elasticsearch.esMajorVersion`     | ES 大版本号，必须为 7。                                                                                                                                    | `7`                                             |
| `elasticsearch.secret.password`    | 密码                                                                                                                                                       | `monkeys123`                                    |
| `elasticsearch.indexReplicasCount` | 索引副本数                                                                                                                                                 | `0`                                             |
| `elasticsearch.clusterHealthColor` | 集群健康颜色指标                                                                                                                                           | `yellow`                                        |


#### 使用外置 Elasticsearch 7


| 参数                                       | 描述                                    | 默认值   |
| ------------------------------------------ | --------------------------------------- | -------- |
| `externalElasticsearch.enabled`            | 是否启用外置的 ES，要求大版本必须为 7。 | `true`   |
| `externalElasticsearch.indexReplicasCount` | 工作流数据副本数                        | `0`      |
| `externalElasticsearch.clusterHealthColor` | 集群健康颜色指标                        | `yellow` |
| `externalElasticsearch.url`                | 连接地址                                | `""`     |
| `externalElasticsearch.username`           | 用户名                                  | `""`     |
| `externalElasticsearch.password`           | 密码                                    | `""`     |


### Redis

#### 使用内置 Redis


| 参数                    | 描述                                                                                                                           | 默认值       |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------ | ------------ |
| `redis.enabled`         | 是否启用内置的 Redis。如果设置为 true，将会创建一个新的 Redis 实例（不保证高可用），如果你有其他现成的 Redis，请设置为 false。 | `true`       |
| `redis.architecture`    | 部署架构，目前只支持 `standalone` 单机模式。                                                                                   | `standalone` |
| `redis.global.password` | 密码                                                                                                                           | `monkeys123` |


#### 使用外置 Redis

##### 单机 Redis

| 参数                    | 描述                                                                                                 | 默认值                     |
| ----------------------- | ---------------------------------------------------------------------------------------------------- | -------------------------- |
| `externalRedis.enabled` | 是否使用外置的 redis                                                                                 | `false`                    |
| `externalRedis.mode`    | Redis 部署架构                                                                                       | `standalone`               |
| `externalRedis.url`     | Redis 连接地址，如 `redis://@localhost:6379/0`，包含密码的示例: `redis://:password@localhost:6379/0` | `redis://localhost:6379/0` |

##### Redis 集群

| 参数                             | 描述                 | 默认值    |
| -------------------------------- | -------------------- | --------- |
| `externalRedis.enabled`          | 是否使用外置的 redis | `false`   |
| `externalRedis.mode`             | Redis 部署架构       | `cluster` |
| `externalRedis.nodes`            | Redis 集群节点列表   | `""`      |
| `externalRedis.options.password` | 密码                 | `""`      |

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

###### Redis sentinel

| 参数                             | 描述                 | 默认值     |
| -------------------------------- | -------------------- | ---------- |
| `externalRedis.enabled`          | 是否使用外置的 redis | `false`    |
| `externalRedis.mode`             | Redis 部署架构       | `sentinel` |
| `externalRedis.sentinels`        | Redis 哨兵节点列表   | `""`       |
| `externalRedis.sentinelName`     | Redis sentinel Name  | `""`       |
| `externalRedis.options.password` | 密码                 | `""`       |

Redis 哨兵节点列表示例：

```yaml
sentinels:
  - host: 127.0.0.1
    port: 7101
```

### MinIO(S3) 存储

#### 使用内置 Minio 存储

> 此模式会使用 root 用户和密码作为 accessKey，只推荐在快速测试时使用。

| 参数                      | 描述                                                                                                                                                          | 默认值           |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| `minio.enabled`           | 是否启用内置的 Minio。如果设置为 true，将会创建一个新的 Minio 实例（不保证高可用），如果你有其他现成的 Minio 或者任意满足 S3 协议的对象存储，请设置为 false。 | `true`           |
| `minio.isPrivate`         | 是否为私有仓库                                                                                                                                                | `false`          |
| `minio.mode`              | 部署架构，目前只支持 `standalone` 单机模式。                                                                                                                  | `standalone`     |
| `minio.defaultBuckets`    | 默认创建的 Bucket Name，可以用逗号分隔。                                                                                                                      | `monkeys-static` |
| `minio.auth.rootUser`     | Root 用户名                                                                                                                                                   | `minio`          |
| `minio.auth.rootPassword` | Root 用户密码                                                                                                                                                 | `monkeys123`     |

| `minio.service.type`              | Minio Service 模式，次 Minio 需要能够被外部（浏览器）访问，默认使用 `Nodeport` 模式。                                                                         | `NodePort`               |
| `minio.service.nodePorts.api`     | Minio API 端口挂载到宿主机的端口                                                                                                                              | `31900`                  |
| `minio.service.nodePorts.console` | Minio Console 端口使用宿主机的端口                                                                                                                            | `31901`                  |
| `minio.endpoint`                  | Minio API 端口对外可被访问到的地址。你可能需要改成宿主机服务器的 IP + API Node Port 端口                                                                      | `http://127.0.0.1:31900` |

启动之后，访问宿主机 IP + 端口（31901） 应该能够访问到 minio 的管理后台，账号密码为上述设置的密码。

> 注：如果你使用的是 minikube 搭建的集群，还需要手动 port forward minio service 的端口，如下所示：
>
> ```bash
> kubectl port-forward svc/monkeys-minio 31900:9000 -n monkeys
> kubectl port-forward svc/monkeys-minio 31901:9001 -n monkeys
> ```
> 并且注意需要开放宿主机的端口，外网才能访问。
> 详情请见 [https://stackoverflow.com/a/55110218](https://stackoverflow.com/a/55110218)。

#### 使用外部 S3 存储

| 参数                         | 描述                                                                                                | 默认值  |
| ---------------------------- | --------------------------------------------------------------------------------------------------- | ------- |
| `externalS3.enabled`         | 使用使用外部的满足你 S3 协议的对象存储，如 Minio、AWS S3 等。                                       | `false` |
| `externalS3.isPrivate`       | 是否为私有仓库                                                                                      | `false` |
| `externalS3.forcePathStyle`  | 是否使用 path-style endpoint, 当你使用 minio 时，一般都需要设置为 `true`                            | `false` |
| `externalS3.endpoint`        | 访问地址                                                                                            | `""`    |
| `externalS3.accessKeyId`     | AccessKeyID                                                                                         | `""`    |
| `externalS3.secretAccessKey` | Secret Access Key                                                                                   | `""`    |
| `externalS3.region`          | 区域                                                                                                | `""`    |
| `externalS3.bucket`          | Bucket 名称，请使用公开的 bucket，以便前端能够访问到。                                              | `""`    |
| `externalS3.publicAccessUrl` | 请填写外部（浏览器）可访问的地址，一般为 Bucket 配置的 CDN 地址，如 `https://static.infmonkeys.com` | `31900` |



## 服务配置


| 参数                | 描述                        | 默认值      |
| ------------------- | --------------------------- | ----------- |
| `service.type`      | `ClusterIP` 或者 `NodePort` | `ClusterIP` |
| `service.port`      | Proxy 组件(Nginx) 暴露端口  | `80`        |
| `service.clusterIP` | ClusterIP                   | `""`        |
| `service.nodePort`  | Node Port 端口              | `""`        |


### ClusterIP 模式示例

```yaml
service:
  type: ClusterIP
  port: 80
  clusterIP: ""
```

### NodePort 模式示例

```yaml
service:
  type: NodePort
  port: 80
  nodePort: 30080
```

## 语言模型配置项说明

你可以按照下面的配置添加任意符合 OpenAI 标准的大语言模型：

| 参数            | 描述                                                                                                                           | 默认值 |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------ | ------ |
| `model`         | model name，如 `gpt-3.5-turbo`                                                                                                 |        |
| `baseURL`       | 访问地址，如 `https://api.openai.com/v1`                                                                                       |        |
| `apiKey`        | APIKey，如果没有可不填。                                                                                                       |        |
| `type`          | 此模型的类型，可选值为 `chat_completions` 和 `completions`，分别表示是一个对话模型还是文本补全模型。不填则表示两种方式都支持。 | `""`   |
| `defaultParams` | 默认请求参数，比如一些模型如 `Qwen/Qwen-7B-Chat-Int4`，需要设置 top 参数。                                                     |        |



以下是一个示例：

```yaml
models:
  - model: gpt-3.5-turbo
    baseURL: https://api.openai.com/v1
    apiKey: xxxxxxxxxxxxxx
    type:
      - chat_completions
  - model: davinci-002
    baseURL: https://api.openai.com/v1
    apiKey: xxxxxxxxxxxxxx
    type:
      - completions
  - model: Qwen/Qwen-7B-Chat-Int4
    baseURL: http://127.0.0.1:8000/v1
    apiKey: token-abc123
    defaultParams:
      stop:
        - <|im_start|>
        - <|im_end|>
```