# Traefik 🛫

**Required Service** - Traefik acts as the reverse proxy and is mandatory for all other services.

## About

Traefik is configured with prebuilt middleware (located in `./dynamic`), such as rate limiting and simple authentication via labels. It exposes the Traefik admin dashboard and uses Let's Encrypt HTTP challenge for TLS certificate provisioning.

![dashboard](../dashboard.png)

## Setup

### Prerequisites

Because of the way certificate challenges work, Traefik needs to be running and ready to respond to ACME challenges from Let's Encrypt. When services start, Traefik discovers them and initiates certificate requests, but Traefik itself must already be running to handle the challenge responses. Therefore, you want to start **Traefik first**, then start your other services.

1. Create the traefik network: `docker network create traefik_public`
2. **Configure Environment Variables:**  
   - Duplicate the `env.example` file to `.env`
   - Fill in information in the environment file.

### Configuration

1. Dashboard is exposed over internet, with the domain provided in `DASHBOARD_DOMAIN` environment var
2. Simple auth `DASHBOARD_AUTH_USERS` environment variable can be generated using `htpasswd -nb <user> <passwd> | sed 's/\$/\$\$/g'` (sed to escape dollar signs)
3. Start with `docker compose up -d`

### TLS Configuration with Let's Encrypt 🔒

1. **Traefik Integration:**  
   Traefik use Let's Encrypt for TLS certificate provisioning.
   Replace the `ACME_EMAIL` placeholder inside [traefik static config file](./traefik.yaml).

2. **Certificate Resolver Configuration:**  
    Create the `acme.json` under `./data/` file

    ```sh
    mkdir ./data && touch ./data/acme.json
    chmod 600 ./data/acme.json
    ```

    On the traefik service launch, http challenge will be resolved

## Using with Your Own Containers

Add _Traefik_ essential labels to your containers, i writing inside a _docker compose_ file

```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.SERVICE_NAME.rule=Host(`domain.com`)"
  - "traefik.http.routers.SERVICE_NAME.tls=true"
  - "traefik.http.routers.SERVICE_NAME.entrypoints=web,websecure"
  - "traefik.http.routers.SERVICE_NAME.tls.certresolver=letsencrypt"
  - "traefik.http.services.SERVICE_NAME.loadbalancer.server.port=PORT"
```
