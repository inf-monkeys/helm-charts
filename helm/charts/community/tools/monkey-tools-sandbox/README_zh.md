# Helm Chart for [monkey-tools-sandbox](https://github.com/inf-monkeys/monkey-tools-sandbox)

## 配置

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