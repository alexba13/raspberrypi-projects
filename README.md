# Raspberry Pi

Currently there are several apps running on my Raspberry Pi. Here is a current list with the link to the documentation:

- [Monitoring](/monitoring/)
- [Grafana Dashboards](/grafana/)
- [Prometheus](/prometheus/)
- [Logging](/logging/)
- [Nextcloud](/nextcloud/)
- [OpenHab](/openhab/)
- [Pi-hole](/pihole/)
- [Portainer](/portainer/)
- [Restic](/restic/)
- [Traefik](/traefik/)

Possible upcoming apps/ideas:
- JuptyerLab-as-a-Service
- Automatic weekly updates (e.g. restic)
- Woodpecker CI install and setup
- Code-Server
- Image-Scanning
- Runtime-Scanning
- Enable Dependabot

Fixes needs to be done:
- update readme files and upload all files to GitHub
- replace node exporter with alloy
- folder usage: sudo du -h --max-depth=1 /var | sort -hr
- adding grafana.db into restic backup
