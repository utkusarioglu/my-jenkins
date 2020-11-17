#!/bin/bash

TAG="myjenkins-blueocean:1.1"
REGISTRY_PORT="5000"
REGISTRY_IP="192.168.1.151"
REPOSITORY_ADDRESS="$REGISTRY_IP:$REGISTRY_PORT"
ADDRESSED_TAG="$REPOSITORY_ADDRESS/$TAG"

echo "Building the docker image..."
docker build -t "$TAG" .

echo "Tagging image for the remote repository address..."
docker tag "$TAG" "$ADDRESSED_TAG"

echo "Pushing the image to: \"$ADDRESSED_TAG\"..."
docker push "$ADDRESSED_TAG"

echo "Push complete"