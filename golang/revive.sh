#!/usr/bin/env bash

: "${REVIVE_CFG:=.revive.toml}"

set -euo pipefail

function abort() {
    if [[ -n "$1" ]]; then
        echo "$1"
    fi
    exit 1
}

REVIVE="$(command -v revive 2>/dev/null)"

while (($# > 0)); do
    case "$1" in
    -c | --cmd)
        REVIVE="$2"
        shift
        shift
        ;;
    esac
done

[[ -n "$REVIVE" ]] || abort "revive not found or not set"
[[ -x "$REVIVE" ]] || abort "$REVIVE not executable"

if [[ ! -f "${REVIVE_CFG}" ]]; then
    command cat >"${REVIVE_CFG}" <<EOF
ignoreGeneratedHeader = false
severity = "warning"
confidence = 0.8
errorCode = 1
warningCode = 2

[rule.blank-imports]
[rule.context-as-argument]
[rule.context-keys-type]
[rule.dot-imports]
[rule.error-return]
[rule.error-strings]
[rule.error-naming]
[rule.exported]
[rule.if-return]
[rule.increment-decrement]
[rule.var-naming]
[rule.var-declaration]
[rule.package-comments]
[rule.range]
[rule.receiver-naming]
[rule.time-naming]
[rule.unexported-return]
[rule.indent-error-flow]
[rule.errorf]
EOF
fi

exec "$REVIVE" -config "${REVIVE_CFG}" ./...
