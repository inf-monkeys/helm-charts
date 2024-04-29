<div align="center">

# Helm Chart for [monkey-tools-sandbox](https://github.com/inf-monkeys/monkey-tools-sandbox)<!-- omit in toc -->

</div>


- [配置项](#配置项)
  - [镜像版本](#镜像版本)
  - [Piston 配置（可选）](#piston-配置可选)
    - [配置项](#配置项-1)
    - [有网环境下添加 Python runtime](#有网环境下添加-python-runtime)
    - [离线网络环境下添加 Python runtime](#离线网络环境下添加-python-runtime)
  - [Sandbox 配置](#sandbox-配置)
  - [Redis](#redis)
    - [单机 Redis](#单机-redis)
    - [Redis 集群](#redis-集群)
      - [Redis sentinel](#redis-sentinel)
- [安装](#安装)
  - [更新配置](#更新配置)
- [卸载](#卸载)

## 配置项

以下是你需要特别关心的一些配置：

### 镜像版本



| 参数                         | 描述                                                                                                                                | 默认值                            |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | --------------------------------- |
| `images.sanbox.repository`   | [https://github.com/inf-monkeys/monkey-tools-sandbox](https://github.com/inf-monkeys/monkey-tools-sandbox) 服务的 Docker 镜像地址。 | `infmonkeys/monkey-tools-sandbox` |
| `images.sandbox.tag`         | 版本号                                                                                                                              | `""`                              |
| `images.sandbox.pullPolicy`  | 镜像拉取策略                                                                                                                        | `IfNotPresent`                    |
| `images.sandbox.pullSecrets` | 拉取镜像的密钥，没有可以不填。                                                                                                      | ``                                |
| `images.piston.repository`   | [piston](https://github.com/engineer-man/piston) 项目的 Docker 镜像地址。                                                           | `ghcr.io/engineer-man/piston`     |
| `images.piston.tag`          | 版本号                                                                                                                              | `latest`                          |
| `images.piston.pullPolicy`   | 镜像拉取策略                                                                                                                        | `IfNotPresent`                    |
| `images.piston.pullSecrets`  | 拉取镜像的密钥，没有可以不填。                                                                                                      | ``                                |

### Piston 配置（可选）

如果需要运行 python 自定义代码，需要配置此部分内容。

#### 配置项


| 参数                                                     | 描述                                                                          | 默认值                   |
| -------------------------------------------------------- | ----------------------------------------------------------------------------- | ------------------------ |
| `piston.enabled`                                         | 使用启用 piston 服务，默认为 false。                                          | `false`                  |
| `piston.replicas`                                        | 副本数                                                                        | `1`                      |
| `piston.resources`                                       | 资源限制                                                                      | 要求 1C 2G，限制 2C 8G。 |
| `piston.extraEnv.PISTON_RUN_TIMEOUT`                     | 执行超时时间，单位为毫秒                                                      | `3600000`                |
| `piston.extraEnv.PISTON_COMPILE_TIMEOUT`                 | 编译超时时间，单位为毫秒                                                      | `3600000`                |
| `piston.extraEnv.PISTON_OUTPUT_MAX_SIZE`                 | 执行 stdout 以及 stderr 最大长度。                                            | `1024`                   |
| `piston.persistence.persistentVolumeClaim`               | 使用 PVC 的方式进行挂载                                                       |                          |
| `piston.persistence.persistentVolumeClaim.existingClaim` | 使用现成的 PVC，留空则表示创建新的。                                          | `""`                     |
| `piston.persistence.hostPath`                            | 使用 Host Path 方式进行挂载                                                   |                          |
| `piston.persistence.hostPath.path`                       | **请指定宿主机的挂载目录**，如 `/var/piston`。如果留空则会使用 PVC 挂载方式。 | `"/piston"`              |
| `piston.persistence.hostPath.type`                       | Host Path 类型                                                                | `DirectoryOrCreate`      |


#### 有网环境下添加 Python runtime

请见 [https://github.com/inf-monkeys/monkey-tools-sandbox](https://github.com/inf-monkeys/monkey-tools-sandbox) 文档。

#### 离线网络环境下添加 Python runtime

1. 下载 [https://static.infmonkeys.com/docker/monkeys/piston/python-3.10.0.tar.gz](https://static.infmonkeys.com/docker/monkeys/piston/python-3.10.0.tar.gz) 文件。
2. 将此压缩包拷贝到宿主机。
3. 将此压缩包移动到宿主机挂载的目录下，如 `/var/piston`，注意和上述配置中的 `persistence.hostPath.path` 保持一致。
4. 解压此压缩包：`unzip python.zip`。
5. 删除 zip 文件：`rm -rf python.zip`。（Piston 启动的时候会扫描此目录，如果有非目录文件会导致启动失败。）
6. 重启 piston pod 使 Runtime 加载生效。

### Sandbox 配置

| 参数                            | 描述                                               | 默认值                   |
| ------------------------------- | -------------------------------------------------- | ------------------------ |
| `sandbox.piston.runTimeout`     | 请和 piston 的 `PISTON_RUN_TIMEOUT` 保持一致。     | `3600000`                |
| `sandbox.piston.compileTimeout` | 请和 piston 的 `PISTON_COMPILE_TIMEOUT` 保持一致。 | `3600000`                |
| `sandbox.replicas`              | 副本数                                             | 1                        |
| `sandbox.resources`             | 资源限制                                           | 要求 1C 2G，限制 2C 8G。 |


### Redis

#### 单机 Redis

| 参数                 | 描述           | 默认值                     |
| -------------------- | -------------- | -------------------------- |
| `externalRedis.mode` | Redis 部署架构 | `standalone`               |
| `externalRedis.url`  | Redis 连接地址 | `redis://localhost:6379/0` |

#### Redis 集群

| 参数                             | 描述               | 默认值    |
| -------------------------------- | ------------------ | --------- |
| `externalRedis.mode`             | Redis 部署架构     | `cluster` |
| `externalRedis.nodes`            | Redis 集群节点列表 | `""`      |
| `externalRedis.options.password` | 密码               | `""`      |

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

| 参数                             | 描述                | 默认值     |
| -------------------------------- | ------------------- | ---------- |
| `externalRedis.mode`             | Redis 部署架构      | `sentinel` |
| `externalRedis.sentinels`        | Redis 哨兵节点列表  | `""`       |
| `externalRedis.sentinelName`     | Redis sentinel Name | `""`       |
| `externalRedis.options.password` | 密码                | `""`       |

Redis 哨兵节点列表示例：

```yaml
sentinels:
  - host: 127.0.0.1
    port: 7101
```


## 安装

1. 安装 chart

```sh
helm install monkey-tools-sandbox . --values ./values.yaml -n monkeys
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
helm upgrade monkey-tools-sandbox . --namespace monkeys --values ./values.yaml --values ./prod-values.yaml
```

## 卸载

```sh
helm uninstall monkey-tools-sandbox
```