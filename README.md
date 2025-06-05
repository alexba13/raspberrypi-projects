# raspberrypi-projects

upcoming:
- UI for Docker Containers
- JuptyerLab-as-a-Service
- Automatic weekly updates (e.g. restic)
- Woodpecker CI install and setup
- Code-Server
- Loki integrated into Grafana

fixes:
- update readme files and upload all files to GitHub
- update nextcloud to latest version
- replace node exporter with alloy


Logs:
```
[ Docker Logs ] --------->  
                          \
                           \
[ Host Logs ] --------> [ Alloy ] --> [ Loki ] --> [ Grafana ]
```

- also possible to use loki as docker driver directly for the docker logs: https://grafana.com/docs/loki/latest/send-data/docker-driver/
- alloy than for the local rpi logs
