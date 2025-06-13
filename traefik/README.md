# Traefik

Since there are several apps running as Docker containers, Traefik is being used as reverse proxy.

:warning:

Before you start with the deployment of Traefik, create the needed Docker network first.

```
docker network create --driver bridge traefik_net
```

:warning:

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
