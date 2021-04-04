#!/usr/bin/env bash

MAKE="$(command -v make 2>/dev/null)"
if [[ -z "$MAKE" ]]; then
    echo "make: not installed"
    exit 1
fi

if (( $# == 0 )); then
    echo "make: no args passed"
    exit 1
fi

"$MAKE" "$@"

# Fail the hook it created any new files
[[ -z "$(command git ls-files --others --exclude-standard --directory)" ]]
