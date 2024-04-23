<div align="center">

# Helm Chart for [monkey-tools-sandbox](https://github.com/inf-monkeys/monkey-tools-sandbox)

</div>

## 配置

以下是你需要特别关心的一些配置：

### 镜像版本

- `images`:
  - `sandbox`: 
    - `repository`: [monkey-tools-sandbox](https://github.com/inf-monkeys/monkey-tools-sandbox) 的 docker 镜像仓库。
    - `tag`: 版本号
    - `pullSecrets`: 拉取镜像的 secret，没有可留空
  - `piston`:
    - `repository`: [piston](https://github.com/engineer-man/piston) 的 docker 镜像仓库。
    - `tag`: 版本号
    - `pullSecrets`: 拉取镜像的 secret，没有可留空

### Piston 配置（可选）

如果需要运行 python 自定义代码，需要配置此部分内容。

#### 配置项

- `piston`:
  - `enabled`: true # 设置为 true，默认为 false
  - `replicas`: 1 # 副本数，默认为 1
  - `resources`: # cpu 和 memory 限制，推荐使用默认配置。
  - `extraEnv`:
    - `PISTON_RUN_TIMEOUT`: 执行超时时间，单位为毫秒
    - `PISTON_COMPILE_TIMEOUT`: 编译超时时间，单位为毫秒
    - `PISTON_OUTPUT_MAX_SIZE`: 执行 stdout 以及 stderr 最大长度。
  - `persistence`:
    - `persistentVolumeClaim`: 使用 pvc 挂载的方式
      - `existingClaim`: 使用现成的 pvc，没有可不填
      - `size`: 大小，一个 Python Runtime 的大小约为 1G，推荐至少给 10G.
    - `hostPath`: 使用 host path 的方式
      - `path`: **请修改为宿主机的挂载目录**，如 `/var/piston`
      - `type`: DirectoryOrCreate

#### 有网环境下添加 Python runtime

请见 [https://github.com/inf-monkeys/monkey-tools-sandbox](https://github.com/inf-monkeys/monkey-tools-sandbox) 文档。

#### 离线网络环境下添加 Python runtime

1. 下载 [https://static.infmonkeys.com/docker/monkeys/piston/python.zip](https://static.infmonkeys.com/docker/monkeys/piston/python.zip) 文件。
2. 将此压缩包拷贝到宿主机。
3. 将此压缩包移动到宿主机挂载的目录下，如 `/var/piston`，注意和上述配置中的 `persistence.hostPath.path` 保持一致。
4. 解压此压缩包：`unzip python.zip`。
5. 删除 zip 文件：`rm -rf python.zip`。（Piston 启动的时候会扫描此目录，如果有非目录文件会导致启动失败。）
6. 重启 piston pod 使 Runtime 加载生效。

### Sandbox 配置

- `sandbox`:
  - `piston`: 
    - `runTimeout`: 请和 piston 的 `PISTON_RUN_TIMEOUT` 保持一致。
    - `compileTimeout`: 请和 piston 的 `PISTON_RUN_TIMEOUT` 保持一致。
  - `replicas`: 1 # 副本数，默认为 1
  - `resources`: # cpu 和 memory 限制，推荐使用默认配置。

### Redis 配置

- `redis`:
  - `url`: Redis 链接

更多详情请见 [./values.yaml](./values.yaml) 文件。


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