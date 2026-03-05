#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ORG="kuai-chuang-chao-xin-xing" REPO="kc-supernova-app" ./scripts/apply-branch-protection.sh
#
# Requirements:
# - gh CLI installed and authenticated with repo admin permission
# - target repository already exists

: "${ORG:?ORG is required}"
: "${REPO:?REPO is required}"

gh api \
  --method PUT \
  -H "Accept: application/vnd.github+json" \
  "/repos/${ORG}/${REPO}/branches/main/protection" \
  --input - <<'JSON'
{
  "required_status_checks": {
    "strict": true,
    "contexts": [
      "lint",
      "unit-test",
      "e2e-test",
      "sast-scan",
      "secrets-scan",
      "dependency-scan"
    ]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true,
    "required_approving_review_count": 1
  },
  "restrictions": null,
  "required_conversation_resolution": true
}
JSON

echo "Branch protection applied: ${ORG}/${REPO}@main"
