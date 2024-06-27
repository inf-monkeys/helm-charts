<div align="center">

# Helm Chart for [monkey-tools-knowledge-base](https://github.com/inf-monkeys/monkey-tools-knowledge-base)

</div>

English | [中文](./README_zh.md)


# English Translation

- [Helm Chart for monkey-tools-knowledge-base](#helm-chart-for-monkey-tools-knowledge-base)
- [English Translation](#english-translation)
  - [Basic Information](#basic-information)
  - [Installation](#installation)
    - [Install Chart](#install-chart)
    - [Check Running Status](#check-running-status)
    - [Import Tools](#import-tools)
    - [Update Configuration](#update-configuration)
    - [Uninstall](#uninstall)
  - [Download Embedding Models (Optional)](#download-embedding-models-optional)
  - [Configuration](#configuration)
    - [Image Versions](#image-versions)
    - [Embedding Models List](#embedding-models-list)

## Basic Information

The `manifestUrl` address for this tool is: `http://monkey-tools-knowledge-base:5000/manifest.json`.

## Installation

### Install Chart

```sh
# Add Chart dependency
helm repo add monkeys https://inf-monkeys.github.io/helm-charts

# Install core service
helm install monkey-tools-knowledge-base monkeys/monkey-tools-knowledge-base -n monkeys --create-namespace
```

<details>
<summary><kbd>Development Mode</kbd></summary>

Helm Chart developers can use the following commands to install locally:

```sh
cd charts/monkey-tools-knowledge-base
helm install monkey-tools-knowledge-base . --values ./values.yaml -n monkeys --create-namespace
```

</details>

### Check Running Status

```sh
kubectl get pods -n monkeys
kubectl get svc -n monkeys
```

### Import Tools

There are two ways to import tools:

1. Import through the `core` service configuration file: Tools imported this way are global tools available to all teams. See [Preset Tools](../core/README_zh.md#预制工具) for details.
2. Manually import through the console page: Tools imported this way are only available to the current team. See [https://inf-monkeys.github.io/docs/zh-cn/tools/use-custom-tools](https://inf-monkeys.github.io/docs/zh-cn/tools/use-custom-tools) for details.

### Update Configuration

Create a new Values yaml file, for example, `prod-core-values.yaml`.

If you need to update the server image, add the following content to `prod-core-values.yaml`:

```yaml
images:
  server:
    tag: some-new-tag
```

Then execute:

```sh
helm upgrade monkey-tools-knowledge-base .  --namespace monkeys --values ./prod-core-values.yaml
```

### Uninstall

```sh
helm uninstall monkey-tools-knowledge-base -n monkeys
```

## Download Embedding Models (Optional)

monkey-tools-knowledge-base uses [FlagEmbedding](https://github.com/FlagOpen/FlagEmbedding) to generate vectors. In a networked environment, the corresponding model can be pulled from huggingface. If your environment is not networked, or if you want to reduce the time consumption of the initial model pull, you can download the model in advance and mount it to the container.

Below is a list of models we provide for quick download and their CDN addresses:

- BAAI/bge-base-zh-v1.5:
    - Description: Embedding suitable for Chinese corpus
    - huggingface repo: https://huggingface.co/BAAI/bge-base-zh-v1.5
    - CDN Download Address: https://static.infmonkeys.com/models/embeddings/bge-base-zh-v1.5.tar.gz

- jinaai/jina-embeddings-v2-base-en:
    - Description: Embedding suitable for English corpus
    - huggingface repo: https://huggingface.co/jinaai/jina-embeddings-v2-base-en
    - CDN Download Address: https://static.infmonkeys.com/models/embeddings/jina-embeddings-v2-base-en.tar.gz

- jinaai/jina-embeddings-v2-small-en:
    - Description: Embedding suitable for English corpus
    - huggingface repo: https://huggingface.co/jinaai/jina-embeddings-v2-small-en
    - CDN Download Address: https://static.infmonkeys.com/models/embeddings/jina-embeddings-v2-small-en.tar.gz

- moka-ai/m3e-base:
    - Description: Embedding suitable for Chinese corpus
    - huggingface repo: https://huggingface.co/moka-ai/m3e-base
    - CDN Download Address: https://static.infmonkeys.com/models/embeddings/jina-embeddings-v2-small-en.tar.gz

After downloading, you need to extract it to the `/app/models` directory of the container and specify these models in the configuration file. See below for details.

## Configuration

### Image Versions

| Parameter                    | Description                     | Default Value                              |
| ---------------------------- | ------------------------------- | ------------------------------------------ |
| `images.server.registry`     | Image registry                  | `docker.io`                                |
| `images.server.repository`   | Image repository                | `infmonkeys/monkey-tools-knowledge-base`   |
| `images.server.tag`          | Version number                  | `""`                                       |
| `images.server.pullSecrets`  | Secret for pulling image, leave empty if none | `""`                                       |
| `images.server.pullPolicy`   | Image pull policy               | `IfNotPresent`                             |

### Embedding Models List

| Parameter                                    | Description                                                                                                                                                                                                                                                                                                           | Default Value |
| -------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| `embeddingsModels`                           | List of embedding models                                                                                                                                                                                                                                                                                              | `[]`          |
| `embeddingsModels[].type`                    | Model type, either `local` (local model) or `api` (custom API interface).                                                                                                                                                                                                                                              | `"local"`     |
| `embeddingsModels[].name`                    | Model name, such as BAAI/bge-base-zh-v1.5, be sure to fill in completely.                                                                                                                                                                                                                                               | `""`          |
| `embeddingsModels[].displayName`             | Display name of the model, used for front-end display, defaults to the same as `name`.                                                                                                                                                                                                                                  |               |
| `embeddingsModels[].dimension`               | Vector dimension.                                                                                                                                                                                                                                                                                                      | `""`          |
| `embeddingsModels[].modelPath`               | Effective only when `type` is `local`. Path to the model, default is `/app/models/xxxxxx`, for example, if the `name` of the model is `BAAI/bge-base-zh-v1.5`, the default path is `/app/models/bge-base-zh-v1.5`; if the `name` is `jinaai/jina-embeddings-v2-small-en`, the default path is `/app/models/jina-embeddings-v2-small-en`. In a networked environment, if this path does not exist, the model will be dynamically pulled from huggingface. | `""`          |
| `embeddingsModels.apiConfig.url`             | Effective only when `type` is `api`. Custom embedding service request address.                                                                                                                                                                                                                                         | `""`          |
| `embeddingsModels[].apiConfig.method`        | Effective only when `type` is `api`. HTTP request method for custom embedding service.                                                                                                                                                                                                                                  | `"POST"`      |
| `embeddingsModels[].apiConfig.headers`       | Effective only when `type` is `api`. HTTP request headers for custom embedding service.                                                                                                                                                                                                                                 | `""`          |
| `embeddingsModels[].apiConfig.body`          | Effective only when `type` is `api`. HTTP request body for custom embedding service.                                                                                                                                                                                                                                    | `""`          |
| `embeddingsModels[].apiConfig.responseResolver` | Effective only when `type` is `api`. Data parsing method for custom embedding service.                                                                                                                                                                                                                                  | `""`          |

Below is a complete example:

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

