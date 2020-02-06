#!/usr/bin/env bash

if ! command -v golint > /dev/null 2>&1; then
    echo "golint not installed"
    exit 1
fi

for go_file in "$@"; do
    if ! command golint -set_exit_status "$go_file" 2>&1; then
        failed="true"
    fi
done

if [[ "$failed" == "true" ]]; then
    echo "golint failed"
    exit 1
fi
