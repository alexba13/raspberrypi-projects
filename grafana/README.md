# Grafana

Grafana will be used for monitoring the different components (Raspberry Pi metrics (e.g. CPU, RAM, Temperature) and Docker metrics).
Also, Loki is integrated as data source to view logs form the Docker containers and some log files stored directly on the Raspberry Pi.

## Grafana dashboards
The Grafana dashboards are stored as JSON file within the `dashboards` folder.

## Grafana database
The Grafana database `grafana.db` is included in the backup of Restic.
