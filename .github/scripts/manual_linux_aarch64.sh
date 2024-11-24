#!/bin/sh

set -ex

IMAGE_NAME=build_openssl_arm64
OPENSSL_VERSION=3.2.0

docker buildx build --platform=linux/arm64 . -t "${IMAGE_NAME}"

docker run -it --entrypoint /bin/bash "${IMAGE_NAME}" &

CONTAINER_ID=$(docker ps -q --filter ancestor="${IMAGE_NAME}")
docker cp "${CONTAINER_ID}":/usr/local/openssl/ arm/
tar -czf "${OPENSSL_VERSION}".tar.gz -C arm .
