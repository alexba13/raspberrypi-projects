# Trivy

Trivy is used for scanning the images for vulnerabilities. For the automated scanning a bash script will be used, which is running every week on Saturday at 10 AM.

This script is added to crontab with `crontab -e`:

```
# Scan job for Trivy scans
0 10 * * 6 /home/pi/trivy/scan_job.sh
```

## Logs

tbd

## Reports

tbd
