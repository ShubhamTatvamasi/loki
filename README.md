# loki

Add grafana helm repo:
```bash
helm repo add grafana https://grafana.github.io/helm-charts
```

Install Grafana:
```bash
helm upgrade -i grafana grafana/grafana \
  --create-namespace \
  --namespace loki \
  --set adminPassword='admin'
```

Install Loki
```
helm pull --untar grafana/loki
cd loki
helm upgrade -i loki grafana/loki \
  --namespace loki \
  -f single-binary-values.yaml
```

Install promtail:
```bash
helm upgrade -i promtail grafana/promtail \
  --namespace loki \
  --set config."clients[0]".url="http://loki:3100/loki/api/v1/push" \
  --set config."clients[0]".tenant_id=foo
```

Access grafana dashboard:
```bash
kubectl port-forward -n loki svc/grafana 3000:80
```

http://localhost:3000/login

Loki Source:
```
http://loki-gateway.loki.svc.cluster.local/
```

HTTP header | Value
---|---
X-Scope-OrgID | foo

---

### OLD

Install loki:
```bash
helm upgrade -i loki grafana/loki \
  --version 6.48.0 \
  --create-namespace \
  --namespace loki \
  --set loki.storage.type=filesystem \
  --set singleBinary.replicas=1 \
  --set loki.useTestSchema=true \
  --set deploymentMode='SingleBinary<->SimpleScalable' \
  --set memcached.enabled=false
```


