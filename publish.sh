#!/usr/bin/env bash
# ============================================================
#  publish.sh — Publish the remotion-motion-graphics skill
#  to GitHub in one command.
#
#  Usage:
#    ./publish.sh                  # uses defaults below
#    ./publish.sh my-repo-name     # custom repo name
#
#  Requirements: git installed. GitHub CLI (gh) recommended —
#  if missing, the script falls back to plain git + manual
#  repo creation instructions.
# ============================================================
set -euo pipefail

# ---------- CONFIG (edit these) ----------
GITHUB_USER="haidrrrry"
REPO_NAME="${1:-remotion-motion-graphics-skill}"
REPO_DESC="Claude Code agent skill for professional Remotion motion graphics — springs, staggering, color grades, grain, and a mandatory render-verify loop. No more generic AI videos."
VISIBILITY="public"          # public | private
DEFAULT_BRANCH="main"
TOPICS="claude,claude-code,remotion,motion-graphics,agent-skills,ai,video,anthropic"
# ------------------------------------------

bold() { printf "\033[1m%s\033[0m\n" "$*"; }
ok()   { printf "\033[32m✔ %s\033[0m\n" "$*"; }
warn() { printf "\033[33m⚠ %s\033[0m\n" "$*"; }
die()  { printf "\033[31m✖ %s\033[0m\n" "$*"; exit 1; }

cd "$(dirname "$0")"

bold "📦 Publishing skill repo: $GITHUB_USER/$REPO_NAME"

# ---------- sanity checks ----------
command -v git >/dev/null 2>&1 || die "git is not installed."
[ -f "remotion-motion-graphics/SKILL.md" ] || die "Run this from the repo root (SKILL.md not found)."

# ---------- .gitignore ----------
if [ ! -f .gitignore ]; then
  cat > .gitignore <<'EOF'
node_modules/
out/
.DS_Store
*.log
.remotion/
EOF
  ok "Created .gitignore"
fi

# ---------- LICENSE (MIT) ----------
if [ ! -f LICENSE ]; then
  cat > LICENSE <<EOF
MIT License

Copyright (c) $(date +%Y) ${GITHUB_USER}

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF
  ok "Created MIT LICENSE"
fi

# ---------- git init + commit ----------
if [ ! -d .git ]; then
  git init -b "$DEFAULT_BRANCH" >/dev/null
  ok "Initialized git repo on '$DEFAULT_BRANCH'"
fi

git add -A
if git diff --cached --quiet; then
  warn "Nothing new to commit."
else
  git commit -m "feat: remotion-motion-graphics Claude agent skill

- SKILL.md with 10 motion design rules + render-verify workflow
- references/motion-patterns.md (17 reusable components)
- references/design-rules.md (color, type, pacing, sound, checklist)
- assets/theme.ts template
- packaged .skill file for Claude.ai" >/dev/null
  ok "Committed"
fi

# ---------- publish ----------
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  bold "🚀 Publishing with GitHub CLI..."
  if gh repo view "$GITHUB_USER/$REPO_NAME" >/dev/null 2>&1; then
    warn "Repo already exists — pushing to it."
    git remote get-url origin >/dev/null 2>&1 || \
      git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"
    git push -u origin "$DEFAULT_BRANCH"
  else
    gh repo create "$GITHUB_USER/$REPO_NAME" \
      --"$VISIBILITY" \
      --description "$REPO_DESC" \
      --source . \
      --push
  fi
  # topics make the repo discoverable
  gh repo edit "$GITHUB_USER/$REPO_NAME" \
    $(printf -- '--add-topic %s ' ${TOPICS//,/ }) >/dev/null 2>&1 || true
  ok "Topics added"
  echo
  bold "✅ Live at: https://github.com/$GITHUB_USER/$REPO_NAME"
else
  warn "GitHub CLI (gh) not found or not authenticated."
  echo
  echo "Option A — install gh and rerun (recommended):"
  echo "    https://cli.github.com  →  gh auth login  →  ./publish.sh"
  echo
  echo "Option B — manual:"
  echo "  1. Create an empty repo at https://github.com/new"
  echo "     Name: $REPO_NAME   (no README, no license — we have them)"
  echo "  2. Then run:"
  echo "     git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git"
  echo "     git push -u origin $DEFAULT_BRANCH"
fi
