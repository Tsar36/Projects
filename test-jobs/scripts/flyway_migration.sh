#!/bin/sh

# Flyway Database Migration Script

# Set the Flyway configuration
FLYWAY_URL="jdbc:postgresql://db_host:5432/db_name"
FLYWAY_USER="db_user"
FLYWAY_PASSWORD="db_password"

# Run Flyway migration
flyway -url="$FLYWAY_URL" -user="$FLYWAY_USER" -password="$FLYWAY_PASSWORD" migrate