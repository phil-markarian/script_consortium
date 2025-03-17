#!/bin/bash

# Stop all running Docker containers
running_containers=$(docker ps -q)
if [ -n "$running_containers" ]; then
    echo "Stopping all running Docker containers..."
    docker stop $running_containers
else
    echo "No running Docker containers to stop."
fi

# Remove all Docker containers
all_containers=$(docker ps -a -q)
if [ -n "$all_containers" ]; then
    echo "Removing all Docker containers..."
    docker rm $all_containers
else
    echo "No Docker containers to remove."
fi

# Remove all Docker volumes
volumes=$(docker volume ls -q)
if [ -n "$volumes" ]; then
    echo "Removing all Docker volumes..."
    docker volume rm $volumes
else
    echo "No Docker volumes to remove."
fi

# Stop and remove containers, networks, and volumes defined in the docker-compose.yml file in the current directory
if [ -f "docker-compose.yml" ]; then
    echo "Stopping and removing containers defined in docker-compose.yml..."
    docker-compose down
else
    echo "No docker-compose.yml file found in the current directory."
fi

echo "Docker cleanup completed."
