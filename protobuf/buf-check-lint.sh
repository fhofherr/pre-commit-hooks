#!/usr/bin/env bash

set -euo pipefail

function abort() {
    if [[ -n "$1" ]]; then
        echo "$1"
    fi
    exit 1
}

BUF="$(command -v buf 2>/dev/null)"

while (($# > 0)); do
    case "$1" in
    -c | --cmd)
        BUF="$2"
        shift
        shift
        ;;
    esac
done

[[ -n "$BUF" ]] || abort "buf not found or not set"
[[ -x "$BUF" ]] || abort "$BUF not executable"

exec "$BUF" check lint
