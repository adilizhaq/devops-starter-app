#!/usr/bin/env bash

URL="http://localhost/health"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')

echo "=== $(date) ==="
if [ "$STATUS" -eq 200 ]; then
  echo "[OK] App is healthy (HTTP $STATUS)"
else
  echo "[ALERT] App returned HTTP $STATUS"
fi
echo "Root disk usage: $DISK_USAGE"
