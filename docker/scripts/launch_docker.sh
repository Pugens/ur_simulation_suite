#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
URCAPS_DIR="$ROOT_DIR/urcaps"
PROGRAMS_DIR="$ROOT_DIR/programs"
URCAP_URL="https://github.com/UniversalRobots/Universal_Robots_ExternalControl_URCap/releases/download/v1.0.5/externalcontrol-1.0.5.urcap"
URCAP_FILE="$URCAPS_DIR/externalcontrol-1.0.5.urcap"
URCAP_JAR="$URCAPS_DIR/externalcontrol-1.0.5.jar"

mkdir -p "$URCAPS_DIR"

if [ ! -f "$URCAP_FILE" ]; then
    echo "Downloading externalcontrol-1.0.5.urcap..."
    curl -fsSL -o "$URCAP_FILE" "$URCAP_URL"
fi

cp -f "$URCAP_FILE" "$URCAP_JAR"

docker network inspect ursim_net >/dev/null 2>&1 || docker network create --subnet=192.168.56.0/24 ursim_net

# Load env vars for ROBOT_MODEL
set -a; source "$ROOT_DIR/docker/.env"; set +a

docker run --rm -it \
    --net ursim_net --ip 192.168.56.101 \
    -e ROBOT_MODEL \
    -p 6080:6080 -p 29999:29999 -p 30001:30001 \
    -p 30004:30004 -p 30002:30002 -p 50002:50002 \
    -v "$URCAPS_DIR:/urcaps" \
    -v "$PROGRAMS_DIR:/ursim/programs" \
    universalrobots/ursim_e-series