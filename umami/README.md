# Umami Analytics 📊

**Optional Service** - Privacy-focused web analytics alternative to Google Analytics.

## About

- Privacy-focused web analytics alternative to Google Analytics
- Integrated with Traefik for SSL termination
- PostgreSQL backend for data persistence
- Self-hosted with full data ownership

## Setup

### Prerequisites

Traefik must be running first as it's mandatory for all services.

### Configuration

1. **Environment Setup:**
   - Copy `.env.example` to `.env` in the `umami/` directory
   - Generate APP_SECRET: `openssl rand -hex 32`
   - Configure `UMAMI_DOMAIN` and `POSTGRES_PASSWORD`

2. **Deploy:** `docker compose up -d`

3. **First Login:**
   - Username: `admin`
   - Password: `umami`
   - Change default password inside settings/user

4. **Add to Services:**
Go to Website -> Add Website enter name and domain then go into Edits -> Tracking Code and copy the tracking code
put the tracking code inside your html file on the service you want to track.