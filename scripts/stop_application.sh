#!/bin/bash
set -e

echo "Stopping application..."

# Stop Docker Compose nếu có
cd /home/ec2-user/deployment
docker compose down || true

# Start dummy service để maintain health check
systemctl start dummy-health.service

echo "Application stopped, dummy service active"