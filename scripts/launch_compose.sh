#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
URCAPS_DIR="$ROOT_DIR/urcaps"
URCAP_URL="https://github.com/UniversalRobots/Universal_Robots_ExternalControl_URCap/releases/download/v1.0.5/externalcontrol-1.0.5.urcap"
URCAP_FILE="$URCAPS_DIR/externalcontrol-1.0.5.urcap"
URCAP_JAR="$URCAPS_DIR/externalcontrol-1.0.5.jar"

mkdir -p "$URCAPS_DIR"

if [ ! -f "$URCAP_FILE" ]; then
    echo "Downloading externalcontrol-1.0.5.urcap..."
    curl -fsSL -o "$URCAP_FILE" "$URCAP_URL"
fi

cp -f "$URCAP_FILE" "$URCAP_JAR"

docker compose -f "$ROOT_DIR/docker-compose.yml" up -d
