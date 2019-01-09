#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER ows WITH PASSWORD 'ows';;
    CREATE DATABASE ows;
    GRANT ALL PRIVILEGES ON DATABASE ows TO ows;
EOSQL