#!/usr/bin/env bash

GO="$(command -v go)"
if [ -z "$GO" ]; then
    echo "go not installed"
    exit 1
fi

export GO111MODULE=on
exec "$GO" mod tidy
