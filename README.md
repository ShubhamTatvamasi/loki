# loki

Add grafana helm repo:
```bash
helm repo add grafana https://grafana.github.io/helm-charts
```

Install loki:
```bash
helm upgrade -i loki grafana/loki \
  --version 6.48.0 \
  --create-namespace \
  --namespace loki \
  --set loki.storage.type=filesystem \
  --set singleBinary.replicas=1 \
  --set loki.useTestSchema=true \
  --set deploymentMode='SingleBinary<->SimpleScalable'
```
