#!/usr/bin/env bash

set -euo pipefail

function abort() {
    if [[ -n "$1" ]]; then
        echo "$1"
    fi
    exit 1
}

GOLINT="$(command -v golint 2>/dev/null)"

while (($# > 0)); do
    case "$1" in
    -c | --cmd)
        GOLINT="$2"
        shift
        shift
        ;;
    esac
done

[[ -n "$GOLINT" ]] || abort "golint not found or not set"
[[ -x "$GOLINT" ]] || abort "$GOLINT not executable"

for go_file in "$@"; do
    if ! "$GOLINT" -set_exit_status "$go_file" 2>&1; then
        failed="true"
    fi
done

if [[ "$failed" == "true" ]]; then
    echo "golint failed"
    exit 1
fi
