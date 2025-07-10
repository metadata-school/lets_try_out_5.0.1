# lets_try_out_5.0.1 - iRODS + PostgreSQL Docker Setup

This repository provides a Docker Compose setup to run an iRODS instance backed by a PostgreSQL 16 database. It uses a shared `.env` file for configuration and mounts a named volume for iRODS data storage.

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

### 2. Create a `.env` File

Create a `.env` file in the root directory:

```env
POSTGRES_PASSWORD=supersecret
DB_USER=irods
DB_NAME=ICAT
```

> 🔐 **Note:** These values are only used by the PostgreSQL container.

### 3. Build and Start the Services

```bash
docker compose up --build
```

This will:

- Pull PostgreSQL 16
- Build the local `irods` image (using `Dockerfile.irods`)
- Create two named volumes:
  - `pgdata` for PostgreSQL data
  - `local_resource` for iRODS-managed files

---

## 📄 Database Initialization

Once the containers are up, initialize the database manually:

```bash
docker compose exec irods bash
./database_init.sh
```

This will:
- Create the `irods` PostgreSQL user with password `testpassword`
- Create the `ICAT` database
- Grant privileges and ownership to the `irods` user

---

## 📁 Volumes

- `pgdata` → PostgreSQL database files
- `local_resource` → Mounted to `/var/lib/irods/local_resource` inside the iRODS container

To inspect the volume on the host:

```bash
docker volume inspect local_resource
```

---

## 🔧 Configuration Notes

- The PostgreSQL service is named `postgres`. iRODS connects using this hostname via internal DNS.
- The iRODS container no longer uses environment variables to configure the database. Initialization is handled by a hardcoded script.

---

## 🧼 Stopping and Cleaning Up

To stop the containers:

```bash
docker compose down
```

To remove volumes as well:

```bash
docker compose down -v
```

---

## 📌 Requirements

- Docker
- Docker Compose v1.27+ or Compose plugin (`docker compose`)

---

## 📬 Questions?

If you're customizing this for your own iRODS deployment, feel free to reach out or open issues for improvements.

---
