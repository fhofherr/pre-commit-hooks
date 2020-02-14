#!/usr/bin/env bash

if ! command -v shellcheck > /dev/null 2>&1; then
    echo "shellcheck not installed"
    exit 1
fi

for sh_file in "$@"; do
    if ! command shellcheck "$sh_file" 2>&1; then
        failed="true"
    fi
done

if [[ "$failed" == "true" ]]; then
    echo "shellcheck failed"
    exit 1
fi
