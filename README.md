# Homelab Configuration 🏗️

This repository contains a configuration that turns a VPS (or any linux system you have in hand) into a home lab, allowing you to host any services you want! 🔬

## Overview
- **Reverse Proxy:** Uses Traefik to expose Docker services over the internet.
- **Observability Stack:** Includes Prometheus and Grafana to monitor your system.
- **Automatic Updates:** Watchtower updates Docker images automatically.

> [!note]
> Watchtower is designed to update tool images automatically to reduce manual work.  
> It is **not** intended to replace a full continuous delivery pipeline!

## Services Included
- **Observability:**  
  - **Prometheus:** Collects metrics from cAdvisor and Node Exporter.  
  - **Grafana:** Creates dashboards using the collected metrics (see the example JPEG in the repository).
- **Reverse Proxy:**  
  - **Traefik:** Configured with prebuilt middleware (located in `./traefik/dynamic`), such as rate limiting and simple authentication via labels.
  - Also exposes the Traefik admin dashboard to the internet.

## Getting Started
1. **Clone the Repository:**  
   Clone this project onto your VPS.
2. **Install Docker:**  
   Make sure Docker is installed on your system.
3. **Configure Environment Variables:**  
   - Duplicate the `env.example` file and rename it to `.env`.
   - Fill in your passwords and usernames.
   - **Important:** Do not commit your `.env` file to your repository!

## Adding a Service
This configuration is built for Docker services, especially those using Docker Compose.
- Create your own `docker-compose.yml` file to run additional services.
- Use Docker labels in your Compose file to integrate with Traefik and expose your service on the internet.

---

Happy Homelabing! 🚀
