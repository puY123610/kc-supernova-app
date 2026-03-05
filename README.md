# GitHub Skeleton Usage

## 1) Copy to your repository root
- `.github/pull_request_template.md`
- `.github/CODEOWNERS`
- `.github/workflows/ci.yml`
- `.github/workflows/security.yml`
- `scripts/apply-branch-protection.sh`

## 2) Make script executable
```bash
chmod +x scripts/apply-branch-protection.sh
```

## 3) Install/login GitHub CLI
```bash
brew install gh
gh auth login
```

## 4) Apply branch protection
```bash
ORG="puY123610" REPO="kc-supernova-app" ./scripts/apply-branch-protection.sh
```

## 5) Set repository settings
- Enable "Require pull request before merging"
- Enable "Require status checks to pass before merging"
- Enable "Require conversation resolution before merging"
- Enable "Require approval from Code Owners"

## Notes
- Replace CODEOWNERS teams with real GitHub teams/users.
- Ensure your `package.json` has scripts:
  - `lint`
  - `test:unit`
  - `test:e2e`
