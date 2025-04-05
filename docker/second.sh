#!/bin/bash

BASE_DIR=./mysterious
PLATFORM=$1
cp docker-compose.yml ${BASE_DIR}/

if [ "$PLATFORM" = "amd64" ]; then
  cp amd64.env ${BASE_DIR}/.env
elif [ "$PLATFORM" = "arm64" ]; then
  cp arm64.env ${BASE_DIR}/.env
fi