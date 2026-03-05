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
  -f required_status_checks.strict=true \
  -f enforce_admins=true \
  -f required_pull_request_reviews.dismiss_stale_reviews=true \
  -f required_pull_request_reviews.required_approving_review_count=1 \
  -f required_pull_request_reviews.require_code_owner_reviews=true \
  -f required_conversation_resolution=true \
  -f restrictions= \
  -F required_status_checks.contexts[]="lint" \
  -F required_status_checks.contexts[]="unit-test" \
  -F required_status_checks.contexts[]="e2e-test" \
  -F required_status_checks.contexts[]="sast-scan" \
  -F required_status_checks.contexts[]="secrets-scan" \
  -F required_status_checks.contexts[]="dependency-scan"

echo "Branch protection applied: ${ORG}/${REPO}@main"
