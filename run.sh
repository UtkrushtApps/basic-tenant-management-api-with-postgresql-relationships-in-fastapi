#!/bin/bash
set -e

echo "Stopping any previous containers..."
docker-compose down || true

echo "Starting up new docker containers..."
docker-compose build
nohup docker-compose up -d &

# Wait for DB to be ready
echo "Waiting for PostgreSQL (db) to initialize..."
RETRIES=30
until docker exec $(docker-compose ps -q db) pg_isready -U utkrusht_admin -d tenant_db || [ $RETRIES -eq 0 ]; do
  sleep 2
  let RETRIES--
done

if [ $RETRIES -eq 0 ]; then
  echo "Database did not come up in time. Exiting."
  exit 1
fi

echo "Applying DB schema..."
docker cp schema.sql $(docker-compose ps -q db):/schema.sql
docker exec -u postgres $(docker-compose ps -q db) psql -U utkrusht_admin -d tenant_db -f /schema.sql

echo "API is available at http://localhost:8000/docs"
echo "Setup complete."
