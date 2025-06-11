# Traefik

Since there are several apps running as Docker containers, Traefik is being used as reverse proxy.
The different routes are configured in each `docker-compose.yml` file as labels.

For example:

```
labels:
  - "traefik.http.routers.dashboard.entrypoints=http"
  - "traefik.enable=true"
  - "traefik.http.routers.dashboard.rule=Host(`dashboard.smart.home`)"
  - "traefik.docker.network=traefik_net"
  - "traefik.http.services.traefik.loadbalancer.server.port=8080"
```

The basic configuration for Traefik is stored in `config/` in this folder.
