#!/bin/bash

# CONFIGURATION
CONTAINER_NAME="pipeline-test-container"
IMAGE_NAME="pipeline-test-image"
# Port mapping (host:container)
PORT="8081:8082"
# Project directory where your git repository exists
PROJECT_DIR="/home/ubuntu/myapp"

echo "-------------------------------"
echo "Starting Deployment..."
echo "-------------------------------"

# Move to project directory
#cd $PROJECT_DIR || exit

# Pull latest code from git repository
echo "1. Pulling latest code from Git..."
git pull origin main

# Clean previous build and create new Maven package
echo "2. Building Maven Project..."
mvn clean package -DskipTests

# Stop running docker container if it already exists
echo "3. Stopping running container (if exists)..."
docker stop $CONTAINER_NAME 2>/dev/null

# Remove existing docker container
echo "4. Removing existing container..."
docker rm $CONTAINER_NAME 2>/dev/null

# Build new docker image from Dockerfile
echo "5. Building new Docker image..."
docker build -t $IMAGE_NAME .

# Create new docker container from image
echo "6. Creating new Docker container..."
docker create \
  --name $CONTAINER_NAME \
  -p $PORT \
  $IMAGE_NAME

# Start the newly created container
echo "7. Starting Docker container..."
docker start $CONTAINER_NAME

echo "-------------------------------"
echo "Deployment Completed Successfully!"
echo "-------------------------------"