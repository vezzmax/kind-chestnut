#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5efa01b70a29a3001bfc502d/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5efa01b70a29a3001bfc502d 
fi
curl -s -X POST https://api.stackbit.com/project/5efa01b70a29a3001bfc502d/webhook/build/ssgbuild > /dev/null
gatsby build
curl -s -X POST https://api.stackbit.com/project/5efa01b70a29a3001bfc502d/webhook/build/publish > /dev/null
