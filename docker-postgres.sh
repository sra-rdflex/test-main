#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
POSTGRES_IMAGE="postgres:15"
CONTAINER_NAME="my_postgres"
POSTGRES_USER="myuser"
POSTGRES_PASSWORD="mypassword"
POSTGRES_DB="mydatabase"
PORT="5432"

# Pull the PostgreSQL Docker image
echo "Pulling PostgreSQL Docker image..."
docker pull $POSTGRES_IMAGE

# Run PostgreSQL container
echo "Starting PostgreSQL container..."
docker run -d \
  --name $CONTAINER_NAME \
  -e POSTGRES_USER=$POSTGRES_USER \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -e POSTGRES_DB=$POSTGRES_DB \
  -p $PORT:$PORT \
  $POSTGRES_IMAGE

echo "PostgreSQL container is up and running."

# Check the status of the container
echo "Checking container status..."
docker ps | grep $CONTAINER_NAME

echo "Setup complete. PostgreSQL is running on port $PORT."
