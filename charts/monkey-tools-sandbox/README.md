<div align="center">

# Helm Chart for [monkey-tools-sandbox](https://github.com/inf-monkeys/monkey-tools-sandbox)<!-- omit in toc -->

</div>

- [Basic Information](#basic-information)
- [Installation](#installation)
  - [Install the Chart](#install-the-chart)
  - [Check the Running Status](#check-the-running-status)
  - [Import Tools](#import-tools)
  - [Update Configuration](#update-configuration)
  - [Uninstall](#uninstall)
- [Configuration Items](#configuration-items)
  - [Image Versions](#image-versions)
  - [Piston Configuration (Optional)](#piston-configuration-optional)
    - [Configuration Items](#configuration-items-1)
    - [Add Python Runtime in Online Environment](#add-python-runtime-in-online-environment)
    - [Add Python Runtime in Offline Environment](#add-python-runtime-in-offline-environment)
  - [Sandbox Configuration](#sandbox-configuration)
  - [Redis (Optional)](#redis-optional)
    - [Standalone Redis](#standalone-redis)
    - [Redis Cluster](#redis-cluster)
    - [Redis Sentinel](#redis-sentinel)

## Basic Information

The `manifestUrl` address for this tool is: `http://monkey-tools-sandbox:3000/manifest.json`.

## Installation

### Install the Chart

```sh
# Add Chart dependency
helm repo add monkeys https://inf-monkeys.github.io/helm-charts

# Install core service
helm install monkey-tools-sandbox monkeys/monkey-tools-sandbox -n monkeys --create-namespace
```

<details>
<summary><kbd>Development Mode</kbd></summary>

Developers of the Helm Chart can use the following commands to install locally:

```sh
cd charts/monkey-tools-sandbox
helm install monkey-tools-sandbox . --values ./values.yaml -n monkeys --create-namespace
```

</details>

### Check the Running Status

```sh
kubectl get pods -n monkeys
kubectl get svc -n monkeys
```

### Import Tools

There are two ways to import tools:

1. Import through the configuration file of the `core` service: Tools imported this way are global tools, accessible by all teams. For details, see [Pre-built Tools](../core/README_zh.md#预制工具).
2. Manually import on the console page: Tools imported this way are only effective for the current team. For details, see [https://inf-monkeys.github.io/docs/zh-cn/tools/use-custom-tools](https://inf-monkeys.github.io/docs/zh-cn/tools/use-custom-tools).

### Update Configuration

Create a new Values yaml file, such as `prod-core-values.yaml`.

For example, if you need to update the sandbox image, add the following content to `prod-core-values.yaml`:

```yaml
images:
  sandbox:
    tag: some-new-tag
```

Then execute:

```sh
helm upgrade monkey-tools-sandbox .  --namespace monkeys --values ./prod-core-values.yaml
```

### Uninstall

```sh
helm uninstall monkey-tools-sandbox -n monkeys
```

## Configuration Items

Below are some configurations you need to pay special attention to:

### Image Versions

| Parameter                    | Description                                                                                                      | Default Value                     |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------- | --------------------------------- |
| `images.sandbox.repository`  | Docker image address of the [monkey-tools-sandbox](https://github.com/inf-monkeys/monkey-tools-sandbox) service. | `infmonkeys/monkey-tools-sandbox` |
| `images.sandbox.tag`         | Version                                                                                                          | `""`                              |
| `images.sandbox.pullPolicy`  | Image pull policy                                                                                                | `IfNotPresent`                    |
| `images.sandbox.pullSecrets` | Secrets for pulling the image, can be left empty if not applicable.                                              | ``                                |
| `images.piston.repository`   | Docker image address of the [piston](https://github.com/engineer-man/piston) project.                            | `ghcr.io/engineer-man/piston`     |
| `images.piston.tag`          | Version                                                                                                          | `latest`                          |
| `images.piston.pullPolicy`   | Image pull policy                                                                                                | `IfNotPresent`                    |
| `images.piston.pullSecrets`  | Secrets for pulling the image, can be left empty if not applicable.                                              | ``                                |

### Piston Configuration (Optional)

If you need to run custom Python code, you need to configure this section.

#### Configuration Items

| Parameter                                                | Description                                                                                                    | Default Value               |
| -------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | --------------------------- |
| `piston.enabled`                                         | Enable piston service, default is false.                                                                       | `false`                     |
| `piston.replicas`                                        | Number of replicas                                                                                             | `1`                         |
| `piston.resources`                                       | Resource limits                                                                                                | Request 1C 2G, limit 2C 8G. |
| `piston.timeouts.runTimeout`                             | Keep consistent with `PISTON_RUN_TIMEOUT` in extraEnv.                                                         | `3600000`                   |
| `piston.timeouts.compileTimeout`                         | Keep consistent with `PISTON_COMPILE_TIMEOUT` in extraEnv.                                                     | `3600000`                   |
| `piston.extraEnv.PISTON_RUN_TIMEOUT`                     | Execution timeout in milliseconds                                                                              | `3600000`                   |
| `piston.extraEnv.PISTON_COMPILE_TIMEOUT`                 | Compilation timeout in milliseconds                                                                            | `3600000`                   |
| `piston.extraEnv.PISTON_OUTPUT_MAX_SIZE`                 | Maximum length of stdout and stderr outputs                                                                    | `1024`                      |
| `piston.persistence.persistentVolumeClaim`               | Mount using PVC                                                                                                |                             |
| `piston.persistence.persistentVolumeClaim.existingClaim` | Use existing PVC, leave empty to create new one.                                                               | `""`                        |
| `piston.persistence.hostPath`                            | Mount using Host Path                                                                                          |                             |
| `piston.persistence.hostPath.path`                       | **Specify the mount directory on the host machine**, e.g., `/var/piston`. Leave empty to use PVC mount method. | `"/piston"`                 |
| `piston.persistence.hostPath.type`                       | Host Path type                                                                                                 | `DirectoryOrCreate`         |

#### Add Python Runtime in Online Environment

See the documentation at [https://github.com/inf-monkeys/monkey-tools-sandbox](https://github.com/inf-monkeys/monkey-tools-sandbox).

#### Add Python Runtime in Offline Environment

1. Download the file [https://static.infmonkeys.com/docker/monkeys/piston/python-3.10.0.tar.gz](https://static.infmonkeys.com/docker/monkeys/piston/python-3.10.0.tar.gz).
2. Copy this tarball to the host machine.
3. Move the tarball to the mount directory specified on the host machine, such as `/var/piston`. Ensure it is consistent with the `persistence.hostPath.path` configuration above.
4. Extract the tarball: `unzip python.zip`.
5. Delete the zip file: `rm -rf python.zip`. (Piston will scan this directory when starting, and non-directory files will cause startup failure.)
6. Restart the piston pod to load the Runtime.

### Sandbox Configuration

| Parameter           | Description        | Default Value               |
| ------------------- | ------------------ | --------------------------- |
| `sandbox.replicas`  | Number of replicas | 1                           |
| `sandbox.resources` | Resource limits    | Request 1C 2G, limit 2C 8G. |

### Redis (Optional)

You only need to configure ES if you have enabled piston.

#### Standalone Redis

| Parameter            | Description                                                                                                          | Default Value              |
| -------------------- | -------------------------------------------------------------------------------------------------------------------- | -------------------------- |
| `externalRedis.mode` | Redis deployment architecture                                                                                        | `standalone`               |
| `externalRedis.url`  | Redis connection URL, e.g., `redis://@localhost:6379/0`. Example with password: `redis://:password@localhost:6379/0` | `redis://localhost:6379/0` |

#### Redis Cluster

| Parameter                        | Description                   | Default Value |
| -------------------------------- | ----------------------------- | ------------- |
| `externalRedis.mode`             | Redis deployment architecture | `cluster`     |
| `externalRedis.nodes`            | List of Redis cluster nodes   | `""`          |
| `externalRedis.options.password` | Password                      | `""`          |

Example of Redis cluster nodes list:

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

#### Redis Sentinel

| Parameter                        | Description                   | Default Value |
| -------------------------------- | ----------------------------- | ------------- |
| `externalRedis.mode`             | Redis deployment architecture | `sentinel`    |
| `externalRedis.sentinels`        | List of Redis sentinel nodes  | `""`          |
| `externalRedis.sentinelName`     | Redis sentinel name           | `""`          |
| `externalRedis.options.password` | Passowrd                      | `""`          |

Example:

```yaml
sentinels:
  - host: 127.0.0.1
    port: 7101
```