#!/usr/bin/env bash
set -euo pipefail

ACR_HOST="npindusdirectacr.azurecr.io"

IMAGES=(
  "docker.io/grafana/loki:3.6.3"
  "docker.io/grafana/grafana:12.3.0"
  "docker.io/grafana/promtail:3.5.1"
  "docker.io/grafana/loki-canary:3.6.3"
  "docker.io/kiwigrid/k8s-sidecar:1.30.9"
  "docker.io/nginxinc/nginx-unprivileged:1.29-alpine"
  "memcached:1.6.39-alpine"
  "prom/memcached-exporter:v0.15.4"
  "quay.io/minio/minio:RELEASE.2024-12-18T13-15-44Z"
  "quay.io/minio/mc:RELEASE.2024-11-21T17-21-54Z"
)

for SRC in "${IMAGES[@]}"; do
  # Strip the source registry to build the destination path under the ACR host
  REPO_TAG="${SRC#*/}"
  DEST="$ACR_HOST/$REPO_TAG"

  echo "Pulling $SRC"
  docker pull "$SRC"

  echo "Tagging $SRC -> $DEST"
  docker tag "$SRC" "$DEST"

  echo "Pushing $DEST"
  docker push "$DEST"

done

echo "Done. Pushed images to $ACR_HOST"
