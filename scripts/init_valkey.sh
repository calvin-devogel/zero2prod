#!/usr/bin/env bash
set -x
set -eo pipefail

# going off on our own again, this time we'll use Valkey instead of Redis
# if a valkey container is running, print instructions to kill it and exit
RUNNING_CONTAINER=$(docker ps --filter 'name=valkey' --format '{{.ID}}')
if [[ -n $RUNNING_CONTAINER ]]; then
    echo >&2 "There is a valkey container already running, kill it with"
    echo >&2 "  docker kill ${RUNNING_CONTAINER}"
    exit 1
fi

# launch Redis using Docker
docker run \
    -p "6379:6379" \
    -d \
    --name "valkey_$(date '+%s')" \
    valkey/valkey:8-alpine

>&2 echo "Valkey is ready to go!"