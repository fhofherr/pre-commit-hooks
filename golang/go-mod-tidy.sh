#!/usr/bin/env bash

set -euo pipefail

function abort() {
    if [[ -n "$1" ]]; then
        echo "$1"
    fi
    exit 1
}

GO="$(command -v go 2>/dev/null)"

while (($# > 0)); do
    case "$1" in
    -c | --cmd)
        GO="$2"
        shift
        shift
        ;;
    esac
done

[[ -n "$GO" ]] || abort "go not found or not set"
[[ -x "$GO" ]] || abort "$GO not executable"

export GO111MODULE=on
exec "$GO" mod tidy
