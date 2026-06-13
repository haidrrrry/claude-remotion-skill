# Design Rules — Color, Type, Pacing, Sound, Checklist

## Color system
One dark (or light) base + ONE hero color + one accent + neutrals. 60/30/10:
60% base, 30% secondary surfaces, 10% hero. The hero color appears on AT MOST
one element per frame — it directs the eye.

Proven palettes (adapt to user's brand if they have one):
- Dark tech: base #0A0A0F, hero #7C3AED, accent #22D3EE, text #F4F4F5
- Warm editorial (Claude-like): base #FAF7F2, hero #D97757, ink #1F1E1B
- Warm premium: base #1A120B, hero #E8A33D, accent #F4E9DA
- Clean light: base #F7F5F2, ink #1A1A1A + one saturated accent

Glow on the hero element only:
`boxShadow: 0 0 60px ${hero}66, 0 0 120px ${hero}33` (text: textShadow).
More than one glowing element per frame = Vegas. Don't.

## Typography
- Hero text: display face (Clash Display, Cabinet Grotesk, General Sans, Satoshi —
  free on Fontshare; or a Google variable font via @remotion/google-fonts).
  Weight 600–800, letterSpacing -0.03em, lineHeight 1.05.
- Reels hero size: 80–140px at 1080 wide. Landscape: 100–160px at 1920.
- Body/captions: a clean sans (Inter/system) at 400–500, dimmed color.
- Highlight ONE word per headline: hero color, animated underline, or a pill
  scaling in behind it 5 frames after the word lands.
- Numbers: animated counters with tabular-nums (see motion-patterns §9).

## Scene architecture
30s Reel structure:
```
0.0–1.5s  HOOK    boldest visual + claim. Movement within the FIRST 15 frames.
1.5–3.0s  CONTEXT one line, one visual, still moving.
3–22s     BODY    3–4 beats. Each beat: HIT -> hold (15–20 still frames) -> build.
22–27s    PAYOFF  the result/number/demo. Biggest animation of the video.
27–30s    CTA     one action, calm, glow on the CTA word.
```
- New visual element at least every 90 frames.
- Holds are a design tool: fast move -> complete stillness -> next move.
  Constant motion reads amateur; contrast reads expensive.
- 9:16 safe zone: critical text inside the middle ~75% vertically (platform UI
  covers top and bottom).
- 5s logo stings: mark in (0–0.8s) -> wordmark (0.6–1.8s) -> detail/tagline
  (2–3.5s) -> breathe -> exit (last 0.5s).

## Sound design (50% of perceived quality — never deliver silent unless asked)
- Every entrance HIT: short whoosh/click starting 2–3 frames BEFORE the visual
  lands (early feels synced; late feels broken).
- Transitions: riser into the cut, bass hit ON the cut.
- Counters: soft tick loop while counting.
- Music bed at low volume (~0.2–0.3), ducked further under VO.
- Pick music FIRST when possible; compute framesPerBeat = fps*60/BPM and place
  cuts on beats.
- Free SFX sources to suggest: Pixabay, Mixkit, freesound.org. A 10-file kit
  covers everything: 2 whooshes, 2 clicks, riser, bass hit, shimmer, tick, pop,
  reverse-swoosh.

## Asset generation guidance (when user generates images for the video)
Lock a prompt skeleton, vary only the subject, keep lighting + palette words
identical across the set, generate at final aspect ratio:
```
[subject], cinematic product photography, dark moody studio, [hero color] rim
lighting, deep shadows, shallow depth of field, 9:16
```

## Render settings
- Masters for upload: `--codec h264 --crf 16` (platforms re-compress; give headroom)
- Heavy transparency/blur stacks: add `--image-format png`
- Preview suspicious motion at 0.25x in Remotion Studio — easing flaws invisible
  at 1x are obvious at quarter speed.

## PRE-DELIVERY CHECKLIST — run against every video before presenting it
- [ ] Zero linear easing anywhere; every interpolate clamped
- [ ] Entrances = 2–3 properties, staggered; nothing enters simultaneously
- [ ] Exits animated, faster than entrances
- [ ] Every still has Ken Burns; fast moves have motion blur
- [ ] 5-layer stack present (bg mesh, assets, graphics, grade, grain+vignette)
- [ ] One hero color, ≤1 hero-colored/glowing element per frame
- [ ] Display font ≥600 weight on heroes; no default-font hero text
- [ ] Pixel gaps (not em) between large text blocks
- [ ] Holds exist: ≥3 moments of stillness
- [ ] SFX on major hits, cuts on beat (if audio in scope)
- [ ] Text inside safe zone; nothing touching frame edges
- [ ] Rendered, frames extracted with ffmpeg, every extracted frame visually
      inspected, issues fixed, re-rendered, re-inspected
