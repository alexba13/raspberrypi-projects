# Logging

To gather the logs from the Docker container and some logs from the Raspberry Pi, Alloy will gather those logs and ship them to Loki.

```
[ Docker Logs ] --------->  
                          \
                           \
[ Host Logs ] --------> [ Alloy ] --> [ Loki ] --> [ Grafana ]
```

## Loki

Loki is used to gather the logs from Alloy. In Grafana, it is defined as data source.
Loki is running as Docker container based on a `docker-compose.yml` file.

The configuration and the Docker Compose file is stored in the folder `loki`. The configuration file for Alloy can be found under `loki/config`.

As storage option, an S3 bucket is configured instead of `filesystem` to avoid storing the information on the SD card of the Raspberry Pi.
The needed information for the S3 bucket needs to be exported over the environment variables.

Loki needs to be setup after Grafana, but before Alloy.

## Alloy

Alloy will be used to gather the different logs as described above.
Alloy is running as Docker container based on a `docker-compose.yml` file.

The configuration and the Docker Compose file is stored in the folder `alloy`. The configuration file for Alloy can be found under `alloy/config`.

The logs, gathered by Alloy, will be send to Loki for the Grafana integration.