#!/bin/bash

# Define the ports you want to free
PORTS=(3100 3200 3300)

for PORT in "${PORTS[@]}"; do
  # Find the process ID (PID) using the port
  PID=$(lsof -ti tcp:$PORT)
  
  # If a process is found, kill it
  if [ -n "$PID" ]; then
    echo "Killing process $PID on port $PORT"
    kill -9 $PID
  else
    echo "No process found on port $PORT"
  fi
done
