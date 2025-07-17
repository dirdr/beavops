# What's up docker 🐋

**Optional Service** - Automatic Docker image update tool.

## About

WUD is designed to update tool images automatically to reduce manual work.

> [!note]
> WUD is **not** intended to replace a continuous delivery pipeline!

## Setup

### Prerequisites

Traefik must be running first as it's mandatory for all services.

### Configuration

1. **Configure Environment Variables:**  
   - Duplicate the `env.example` file to `.env`
   - Generate password hash using : `htpasswd -nb <user> <password> | sed 's/\$/\$\$/g'` (sed to escape dollar signs)
   - Fill in information in the environment file.

2. The wud service need to be started : `docker compose up -d` in the service directory
