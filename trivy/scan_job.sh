#!/bin/bash

set -euo pipefail
trap 'echo "Script failed at line $LINENO"; exit 1' ERR

TODAY=$(date +%d-%m-%y)
LOG_DIR="/home/pi/trivy/logs/logs-$TODAY"
LOG_FILE="/home/pi/trivy/logs/logs-$TODAY/trivy-scans.log"
REPORT_DIR="/home/pi/trivy/reports/reports-$TODAY"

mkdir -p "$LOG_DIR"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "--- Start of scans on $TODAY ---"

echo "--- Logging directory created ---"

export REPORT_DIR
mkdir -p "$REPORT_DIR"
echo "--- Report directory created ---"

echo "--- Logging to $LOG_FILE ---"
echo "--- Reports saved to $REPORT_DIR ---"

IMAGES=$(docker images --format "{{.Repository}}")

echo "--- Start of image scans ---"

for IMAGE in $IMAGES; do
    echo "--- Start scan of $IMAGE ---"
    REPORT_NAME=$(echo "$IMAGE" | sed 's/\//_/g')
    echo $REPORT_NAME
    if [ "$IMAGE" == "nextcloud" ]; then
        docker compose run --rm trivy image --timeout 5m --scanners vuln --format template --template "@contrib/html.tpl" -o /reports/report-$REPORT_NAME.html $IMAGE
    else
        docker compose run --rm trivy image --timeout 5m --format template --template "@contrib/html.tpl" -o /reports/report-$REPORT_NAME.html $IMAGE
    fi
done

echo "--- Scan completed successfully ---"
