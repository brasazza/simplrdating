#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
if ! command -v gitleaks >/dev/null 2>&1; then
  echo 'Install Gitleaks v8.30.1 or newer from https://github.com/gitleaks/gitleaks before committing.' >&2
  exit 2
fi
args=(--config .gitleaks.toml --redact=100 --no-banner --ignore-gitleaks-allow)
case "${1:-history}" in
  --staged) exec gitleaks git --pre-commit --staged "${args[@]}" ;;
  history) exec gitleaks git --log-opts='--all --full-history' "${args[@]}" ;;
  *) echo 'Usage: bash scripts/check-secrets.sh [--staged|history]' >&2; exit 2 ;;
esac
