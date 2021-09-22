#!/bin/bash

DOCKER_USER=waisy
PRESTO_VERSION=0.261
VERSION=v1
# PRESTO_BIN

set -e

# presto
docker build 
    -f ./Dockerfile \
    -t ${DOCKER_USER}/presto:${PRESTO_VERSION}-${VERSION} \
    --build-arg PRESTO_VERSION=$PRESTO_VERSION \
     .
