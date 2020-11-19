#!/bin/bash

source .env

REPOSITORY_ADDRESS="$REGISTRY_IP:$REGISTRY_PORT"
ADDRESSED_TAG="$REPOSITORY_ADDRESS/$MYJENKINS_IMAGE"

echo "Building the docker image..."
docker build -t "$MYJENKINS_IMAGE" .

echo "Tagging image for the remote repository address..."
docker tag "$MYJENKINS_IMAGE" "$ADDRESSED_TAG"

echo "Pushing the image to: \"$ADDRESSED_TAG\"..."
docker push "$ADDRESSED_TAG"

echo "Push complete"