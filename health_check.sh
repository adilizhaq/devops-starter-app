#!/usr/bin/env bash
set -u

# Override with: URL=http://host:port/health ./health_check.sh
URL="${URL:-http://localhost:5000/health}"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 3 --max-time 5 "$URL")
STATUS=${STATUS:-000}
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')

echo "=== $(date) ==="
if [ "$STATUS" -eq 200 ]; then
  echo "[OK] App is healthy (HTTP $STATUS)"
  RC=0
else
  echo "[ALERT] App returned HTTP $STATUS"
  RC=1
fi
echo "Root disk usage: $DISK_USAGE"
exit "$RC"
