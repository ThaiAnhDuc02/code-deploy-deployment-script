#!/bin/bash
set -e

echo "Starting application..."

cd /home/ec2-user/deployment

# Stop dummy health service (chiếm port 80)
sudo systemctl stop dummy-health.service || true

sleep 2

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 730335321184.dkr.ecr.ap-southeast-1.amazonaws.com

docker compose up -d

# Wait for app to be ready
for i in {1..10}; do
    echo "Waiting... ($i)"
    if curl -fs http://localhost/health >/dev/null 2>&1; then
        echo "Application started successfully"
        exit 0
    fi
    sleep 5
done

echo "Application failed to start, reverting to dummy"
docker compose down || true
sudo systemctl start dummy-health.service
exit 1
