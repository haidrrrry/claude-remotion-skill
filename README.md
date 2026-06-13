# 🎬 remotion-motion-graphics — Claude Agent Skill

An agent skill that teaches **Claude Code (Sonnet / Opus)** to create and edit
**professional motion graphics with [Remotion](https://remotion.dev)** — instead of
the generic, linear-fade AI video output you get by default.

Built on a simple thesis: *Remotion is never the bottleneck — motion design craft is.*
This skill encodes that craft as hard rules the model must follow, plus a mandatory
**render → extract frames → visually inspect → fix → re-render** loop so Claude
verifies its own output like an editor instead of shipping blind.

## ✨ What it enforces

| Without this skill | With this skill |
|---|---|
| Linear interpolation everywhere | Springs + bezier curves only (`easeOutExpo`, presets) |
| Lonely opacity fades | 3-property entrances (fade + rise + scale) |
| Everything enters at once | Staggered choreography (3–6 frame offsets) |
| Flat solid backgrounds | Drifting gradient mesh + grade + grain + vignette stack |
| Static pasted images | Ken Burns on every still, `OffthreadVideo` for footage |
| Ships unverified renders | ffmpeg frame extraction + visual inspection, every time |

## 📦 What's inside

```
remotion-motion-graphics/
├── SKILL.md                    # Workflow + 10 non-negotiable motion rules
├── references/
│   ├── motion-patterns.md      # 17 copy-paste components (reveals, grade, grain,
│   │                           #   Ken Burns, counters, transitions, captions...)
│   └── design-rules.md         # Palettes, typography, pacing, sound, checklist
└── assets/
    └── theme.ts                # Theme template (colors, easings, spring presets)
```

## 🚀 Install

**Claude Code (per-user):**
```bash
git clone https://github.com/haidrrrry/remotion-motion-graphics-skill.git
mkdir -p ~/.claude/skills
cp -r remotion-motion-graphics-skill/remotion-motion-graphics ~/.claude/skills/
```

**Claude Code (per-project):** copy the folder into `.claude/skills/` in your repo.

**Claude.ai:** upload `remotion-motion-graphics.skill` in Settings → Capabilities → Skills.

## 🎯 Usage

Just talk to Claude Code normally — the skill triggers itself:

- *"Create a 5 second logo animation for my brand"*
- *"My Remotion video looks generic and basic, fix it"*
- *"Add word-synced captions to this clip"*
- *"Build a vertical Reel intro, dark tech aesthetic"*

Claude will read the skill, apply the motion rules, render with Remotion, extract
frames with ffmpeg, inspect them, fix issues, and only then deliver.

## 🧠 The 10 rules (short version)

1. Never linear interpolation — springs/bezier + clamp, always
2. Entrances animate 2–3 properties together
3. Stagger everything
4. Exits exist and are faster than entrances
5. Five-layer stack: bg mesh → assets → graphics → grade → grain+vignette
6. Every still gets Ken Burns; footage uses `OffthreadVideo`
7. Idle elements breathe (sin-wave micro-motion)
8. All timing derives from `fps` — no magic frame numbers
9. One `theme.ts` — no inline colors or easings
10. Render → inspect frames → fix → re-render. Never ship unverified.

## 📄 License

MIT — use it, fork it, ship videos with it.

---

Made by [@haidrrrry](https://github.com/haidrrrry) · Follow [@haidercodes](https://instagram.com/haidercodes) for AI + dev content
