#!/bin/bash
set -e

echo "Validating service..."

# Check if service is responding
for i in {1..10}; do
    if curl -f http://localhost:80/health 2>/dev/null; then
        echo "Service validation successful"
        exit 0
    fi
    echo "Attempt $i failed, waiting..."
    sleep 5
done

echo "Service validation failed"
exit 1