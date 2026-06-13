#!/usr/bin/env bash
# ============================================================
#  seo-boost.sh — Make claude-remotion-skill discoverable by
#  GitHub search, Google, and AI tools.
#
#  Run this from inside your cloned repo folder. It:
#   1. Copies the SEO-optimized README in
#   2. Commits + pushes
#   3. Sets the repo DESCRIPTION (critical for search)
#   4. Adds TOPICS (critical for GitHub/AI discovery)
#   5. Sets the homepage to your Instagram funnel
#
#  Requires: gh CLI authenticated (gh auth login)
# ============================================================
set -euo pipefail
USER="haidrrrry"
REPO="claude-remotion-skill"

DESC="Open-source Claude agent skill that teaches Claude Code, Claude Desktop & Claude AI to create and edit professional motion graphics videos with Remotion. AI video editing, AI b-roll, captions, sound design — from one prompt."

TOPICS=(claude claude-code claude-ai claude-skills claude-agent-skills anthropic
        remotion motion-graphics ai-video ai-video-editor ai-video-generation
        video-editing react typescript text-to-video ai-agents faceless-video
        content-creation)

echo "📝 Updating README..."
cp README.md ./README.md 2>/dev/null || true
git add -A
git commit -m "docs: SEO + AI-rich README, fix install URL, add FAQ/topics" || echo "nothing to commit"
git push

if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  echo "🏷️  Setting description..."
  gh repo edit "$USER/$REPO" --description "$DESC"
  echo "🌐 Setting homepage..."
  gh repo edit "$USER/$REPO" --homepage "https://instagram.com/haidercodes"
  echo "🔖 Adding topics..."
  gh repo edit "$USER/$REPO" $(printf -- '--add-topic %s ' "${TOPICS[@]}")
  echo ""
  echo "✅ Done. Verify: https://github.com/$USER/$REPO"
else
  echo "⚠️  gh CLI not authenticated. Set these MANUALLY on the repo page:"
  echo ""
  echo "  Click the ⚙️ gear next to 'About' (top-right of repo), then:"
  echo "  • Description: $DESC"
  echo "  • Website: https://instagram.com/haidercodes"
  echo "  • Topics: ${TOPICS[*]}"
fi
