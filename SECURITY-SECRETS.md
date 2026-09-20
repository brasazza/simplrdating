# Secret handling

Store real credentials in an ignored local `.env` file or the deployment's secret manager. Commit only empty/example values. Private repositories also require this protection. Never put provider keys in browser code or variables exposed to the browser (such as `NEXT_PUBLIC_*` or `VITE_*`).

## Before committing

Install Gitleaks v8.30.1 or newer from its official repository: https://github.com/gitleaks/gitleaks

Run `bash scripts/check-secrets.sh --staged` after staging changes. To use the included pre-commit hook, check `git config --get core.hooksPath` and your existing hooks first. If none are configured, run `git config --local core.hooksPath .githooks`. If hooks already exist, integrate this check into them instead of replacing them. Hooks are local to each clone and must be installed there.

`bash scripts/check-secrets.sh` scans all locally available Git history. GitHub Actions runs the same check on pushes and pull requests, using a pinned scanner and verified download checksum. CI detects leaks after code reaches GitHub; the local hook and GitHub push protection are the preventive layers. Enable repository push protection when your plan and permissions support it, and make `Secret scan / secrets` a required status check where available.

## If a credential was committed

Rotate/revoke it with the provider and update the deployment. Removing a line or adding `.gitignore` does not invalidate the old key or remove it from history. Coordinate any history rewrite with collaborators; do not force-push without that coordination. The full-history scan intentionally continues to flag historical credentials until remediation is complete. Never suppress a real credential simply to make CI pass.

For a wallet private key, treat that wallet as compromised. Its owner must migrate remaining assets and permissions to a newly generated wallet using a trusted wallet application; the old key cannot be rotated in place.

The only scanner exceptions, if present, are exact public token addresses confirmed by code context. No API keys or wallet private keys are excluded.
