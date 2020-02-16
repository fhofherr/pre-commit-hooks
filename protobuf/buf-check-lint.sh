#!/usr/bin/env bash

BUF="$(command -v buf)"
if [ -z "$BUF" ]; then
    echo "buf not installed"
    exit 1
fi

exec "$BUF" check lint
