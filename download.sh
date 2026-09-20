#!/usr/bin/env bash
set -euo pipefail

BASE_URL="https://huggingface.co/datasets/illeatmyhat/uspto-trademarks-bronze/resolve/main/annual"
OUT_DIR="$HOME/Downloads/uspto/annual"
URLS_FILE="$OUT_DIR/uspto_parts_37_91.txt"

mkdir -p "$OUT_DIR"
: > "$URLS_FILE"

for i in $(seq -w 37 91); do
  echo "$BASE_URL/apc18840407-20251231-${i}.zip?download=true" >> "$URLS_FILE"
done

aria2c \
  --input-file="$URLS_FILE" \
  --dir="$OUT_DIR" \
  --continue=true \
  --max-concurrent-downloads=8 \
  --split=8 \
  --min-split-size=8M \
  --max-connection-per-server=8 \
  --file-allocation=none \
  --auto-file-renaming=false \
  --allow-overwrite=false \
  --summary-interval=10 \
  --console-log-level=notice
