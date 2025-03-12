![Gitleaks](https://github.com/dirdr/homelab_config/actions/workflows/gitleaks.yaml/badge.svg)

# Homelab Configuration 🏗️

Turns a VPS (or any Linux system you have in hand) into a home lab, allowing you to host and expose services to the internet! 🔬

- **Reverse Proxy:** Uses Traefik to expose Docker services over the internet.
- **Observability Stack:** Includes Prometheus and Grafana to monitor the infrastructure and containers.
- **Automatic Updates:** Watchtower updates Docker images automatically.

## Services Included 📦
- **Traefik:**
  - Configured with prebuilt middleware (located in `./traefik/dynamic`), such as rate limiting and simple authentication via labels.
  - Exposes the Traefik admin dashboard to the internet.
  - Uses Let's Encrypt HTTP challenge for automatic TLS certificate provisioning.
  
  ![dashboard](./dashboard.png)

- **Observability:**  
  - **Prometheus:** Collects metrics from cAdvisor (containers) and Node Exporter (infrastructure).  
  - **Grafana:** Visualizes metrics coming from Prometheus.
  
  ![grafana](./grafana.png)

---

## Getting Started 🚀
1. Clone the Repository:
2. Install Docker and Docker Compose
3. Create the traefik network : `docker network create traefik_public`
4. **Configure Environment Variables:**  
   - Duplicate the `env.example` files for each service you want to use and rename them to `.env`.
   - Fill in the necessary information in each environment file.
   - **Important:** Do not commit your `.env` files to your repository!
     
### Traefik 🛫
1. The traefik dashboard is exposed over internet, with the domain provided in `DASHBOARD_DOMAIN` environment variable
2. Simple auth `DASHBOARD_AUTH_USERS` environment variable can be generated using the `./traefik/scripts/generate_simple_auth.sh`

### Grafana Setup 📊

1. **Deploy Grafana:**  
   Launch the stack with Docker Compose: `docker compose up -d`.
3. **Access the Interface:**  
   Navigate to your Grafana URL (setted in the env file : `GRAFANA_DOMAIN`.
4. **Login & Update Credentials:**  
   - to connect, use the values specified in the env file : `GF_ADMIN_SECURITY_USER` and `GF_ADMIN_SECURITY_PASSWORD`.
5. **Configure Data Source:**
   - In the Grafana sidebar, click on **Configuration** (gear icon) and then **Data Sources**.
   - Click **Add data source**, choose **Prometheus**, and set the URL to `http://prometheus:9090`.
   - Click **Save & Test** to verify connectivity.
6. **Dashboard Setup (Optional):**
   - Import pre-built dashboards by clicking the **+** icon on the left sidebar and selecting **Import**.
   - You can use dashboard IDs from the [Grafana Dashboard Library](https://grafana.com/grafana/dashboards) or create your own.

### TLS Configuration with Let’s Encrypt 🔒

1. **Traefik Integration:**  
   Traefik is pre-configured to use Let’s Encrypt for automatic TLS certificate provisioning.
   Replace the `ACME_EMAIL` placeholder inside [traefik static config file](./traefik/traefik.yaml).

3. **Certificate Resolver Configuration:**  
    Create the `acme.json` under `./traefik/data/` file and give it correct rights
    ```sh
    mkdir ./traefik/data && touch ./traefik/data/acme.json
    chmod 600 ./traefik/data/acme.json
    ```
### Watchtower 🗼
The watchtower service just need to be started : `docker compose up -d` in the service directory

> [!note]
> Watchtower is designed to update tool images automatically to reduce manual work.
> It is **not** intended to replace a continuous delivery pipeline!
    On the next traefik service launch, your http challenge will be resolved, and you will be able to use the `websecure` entrypoint already configured to use TLS with the certificate

## Contributing

Contributions are welcome and appreciated! 🎉

If you have suggestions, ideas, or find any issues, feel free to open an issue or submit a pull request.
If you're not sure where to start, feel free to reach out or open a discussion.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
