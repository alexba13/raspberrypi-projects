# Monitoring
For monitoring the different components and collection the metrics, a stack of Prometheus, Node Exporter, cAdvisor and Grafana is used.
All those apps are running as Docker containers as defined in the `docker-compose.yml` file in this folder.

## Textfile collector
The textfile collector will collect logs from the Raspberry Pi directly every 15 minutes.
To get this running, crontab needs to be updated with `crontab -e` as the non-root user:

```
# Folder usage via Node exporter textfile collector
*/15 * * * * /home/pi/monitoring/textfile-collector/folder_usage_exporter.sh
```
