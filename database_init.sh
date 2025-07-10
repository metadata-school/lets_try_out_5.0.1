#!/bin/bash
set -euo pipefail

# Wait for PostgreSQL to be ready
until pg_isready -h postgres -p 5432 -U postgres; do
  echo "[INFO] Waiting for PostgreSQL at postgres:5432..."
  sleep 2
done

echo "[INFO] PostgreSQL is ready. Running database setup..."

PGPASSWORD="supersecret" psql -h postgres -U postgres -d postgres <<EOF
CREATE USER irods WITH PASSWORD 'testpassword';
CREATE DATABASE "ICAT";
GRANT ALL PRIVILEGES ON DATABASE "ICAT" TO irods;
ALTER DATABASE "ICAT" OWNER TO irods;
EOF

echo "[INFO] Database initialization completed."
