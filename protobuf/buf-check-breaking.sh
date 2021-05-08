#!/usr/bin/env bash

set -euo pipefail

function abort() {
    if [[ -n "$1" ]]; then
        echo "$1"
    fi
    exit 1
}

BUF="$(command -v buf 2>/dev/null)"
TAG="$(git describe --tags --abbrev=0 --match 'v*' 2>/dev/null || echo -n)"

while (($# > 0)); do
    case "$1" in
    -c | --cmd)
        BUF="$2"
        shift
        shift
        ;;
    -t | --tag)
        TAG="$2"
        shift
        shift
        ;;
    esac
done

[[ -n "$BUF" ]] || abort "buf not found or not set"
[[ -x "$BUF" ]] || abort "$BUF not executable"

if [[ -z "$TAG" ]]; then
    echo "No tag to compare found"
    exit 0
fi

exec "$BUF" breaking --against ".git#tag=$TAG"
