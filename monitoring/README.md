# Monitoring
tbd

## Textfile collector
The textfile collector will collect logs from the Raspberry Pi directly.
To get this running, the crontab needs to be updated with `crontab -e` as the non-root user.


This needs to be added:

```
# Folder usage via Node exporter textfile collector
*/15 * * * * /home/pi/monitoring/textfile-collector/folder_usage_exporter.sh
```