---
name: blindbox-new-series
description: Turn a newly-pushed Image/<folder> of personal-collection photos in this ChildPlay repo into a new series for blind-box-gacha.html (curate ~30 regular + 1 hidden item, name them, wire them into prepare_blindbox_assets.py and the game's RAW_SERIES data, regenerate assets locally, test, and commit only code). Use when the user says they added/pushed a new image folder and want it turned into a blind box series, or asks to add a new series to 盲盒收藏樂園.
---

# Blind Box Gacha: add a new series from a pushed image folder

This repo's `blind-box-gacha.html` ("盲盒收藏樂園・臻藏版") is a **private, local-only**
personal collection game. Real copyrighted character photos live under `Image/<系列資料夾>/`
(pushed by the user from their own machine) and get curated down into
`assets/blindbox-photos/<series-id>/` by `prepare_blindbox_assets.py`. That output folder is
gitignored and must never be committed — only the code that references it by relative path
goes into git.

## Before doing anything: safety gates

1. **Confirm the repo is Private.** Run `curl -sS -o /dev/null -w "%{http_code}" https://github.com/<owner>/<repo>`
   with no auth — `404` means private (good), `200` means public. If it's public, **stop and tell the user**
   before touching any real photos; this whole workflow assumes personal/private use only, per the
   established agreement with the user (see repo README's blind-box section for the full context).
2. **Never commit images.** Check `.gitignore` contains `assets/blindbox-photos/` before any `git add`.
   Only `prepare_blindbox_assets.py`, `blind-box-gacha.html`, `index.html`, and `README.md` should be staged.
3. **Content filter while curating** (apply every time, no exceptions):
   - Exclude sexualized/skimpy/suggestive fan art, even if stylistically consistent with the rest.
   - Exclude photos of real people (cosplay photos, influencer photos) — privacy, not just tone.
   - Exclude images that are clearly a different, unrelated franchise (wallhaven-tag mismatches happen constantly).
   - Prefer official art / key visuals / calendar art / clean fan art over generic scenery.
   - Generic scenery/background-only images are acceptable *filler* only when the source pool is thin
     and more characters aren't available — never as a first choice.

## Step by step

1. **Find the new folder.** `git -c core.quotepath=false ls-tree -r --name-only origin/main -- Image | awk -F/ '{print $2}' | sort -u`
   lists all folders under `Image/`; cross-reference against the `folder` values already used in
   `prepare_blindbox_assets.py`'s `PICKS` dict to find which one(s) are new. If the user names the
   folder directly, skip this step.

2. **Generate a contact sheet** instead of opening images one by one:
   ```
   python3 .claude/skills/blindbox-new-series/scripts/contact_sheet.py "Image/<新資料夾>" /tmp/<scratch>/contact
   ```
   This prints `INDEX <i> <filename>` for every image (needed later to map a picked index back to
   a real filename) and writes numbered thumbnail grids (`sheet_0000.jpg`, `sheet_0064.jpg`, ...) —
   read those with the Read tool to actually see the content. A folder can easily be 100+ MB of full-res
   images; never open every file individually, and never skip the review step even under time pressure —
   that review is what catches copyright mismatches and inappropriate content.

3. **Pick ~30 regular + 1 hidden image**, applying the content filter above. If the folder has fewer
   than 31 usable images (this has happened — one source folder only had 38 total, another 41), use
   nearly the whole pool rather than refusing; the user has explicitly said they'd rather have a full
   30-item series with a couple of weaker filler picks than a short series. Pick one especially striking
   / rare-looking / "grand ensemble" image as the hidden item — it should visually read as a jackpot.

4. **Name every picked item** in Traditional Chinese, matching the tone of existing series (real
   character names where recognizable, short scene descriptions otherwise, e.g. "紅皮克敏行軍" or
   "全員集合・名偵探柯南" for a grand hidden poster). Keep names short enough to read on a card.

5. **Choose series metadata**: a short ascii `id` (lowercase, no spaces — used as both the dict key and
   the `assets/blindbox-photos/<id>/` folder name), the Chinese `name`, one emoji `icon`, and two hex
   colors `accentA`/`accentB` that fit the franchise's palette (see existing entries in `RAW_SERIES` for
   the pattern — e.g. nature green for Pikmin, teal/red for Demon Slayer).

6. **Add the entry to `prepare_blindbox_assets.py`**, in the `PICKS` dict, following the exact shape of
   the existing entries: `"folder"` (the Chinese `Image/` subfolder name), `"regular"` (list of
   `(filename, label)` tuples, in the order you want them numbered `01.jpg`..`NN.jpg`), `"hidden"`
   (one `(filename, label)` tuple). Then run `python3 prepare_blindbox_assets.py` (or `py -3.14
   prepare_blindbox_assets.py` if that's what resolves Python on the user's Windows machine — ask if
   unsure) and confirm the new series prints `"<id> done, N regular + 1 hidden"` with N matching what
   you picked, before moving on.

7. **Add the `RAW_SERIES` entry** in `blind-box-gacha.html`. Don't hand-transcribe — generate it from the
   same `PICKS` dict to avoid drift between the two files:
   ```python
   import re
   src = open("prepare_blindbox_assets.py", encoding="utf-8").read()
   ns = {}
   exec(compile(src.split("def process")[0], "picks", "exec"), ns)
   cfg = ns["PICKS"]["<new-id>"]
   # then build:  { id: "<new-id>", name: "...", icon: "...", accentA: "...", accentB: "...",
   #   items: [["01.jpg","label"], ...], hiddenFile: "hidden.jpg", hiddenName: "..." }
   ```
   Insert it as a new element of the `RAW_SERIES` array (comma after the previous entry's closing `}`).

8. **Update the hardcoded series/item counts** — grep for the previous series count and total collectible
   count and bump them in: the `.subtitle` div in `blind-box-gacha.html`, the game's card description in
   `index.html`, and the "共 N 個系列、共 M 款" line in `README.md`'s blind-box section (M = 31 × series
   count only if every series has exactly 30+1; recompute from actual per-series counts otherwise).

9. **Test before committing.** Syntax-check the extracted `<script>` block with `node --check`, then drive
   it with Playwright (Chromium is preinstalled at `/opt/pw-browsers/chromium-*/chrome-linux/chrome`,
   launch with `args: ['--no-sandbox']`): confirm `.series-card` count matches the new total, open the
   new series' box view, confirm tile count, do one full tear-drag-reveal cycle, and check `pageerror`
   listeners stay empty. A `net::ERR_CONNECTION_RESET` console message for the Google Fonts stylesheet
   is expected (no network in this environment) and not a real error.

10. **Commit and push code only.** `git add prepare_blindbox_assets.py blind-box-gacha.html index.html
    README.md` — never `assets/` or the `Image/` folder itself. Double-check `git status --short` shows
    no `assets/blindbox-photos` entries before committing.

## Notes from past runs

- Wallhaven-tag scrapes for a franchise reliably pull in: real-person cosplay photos, unrelated
  crossover fan art, and occasionally skimpy/suggestive art even when a "SFW" filter was supposedly
  used upstream. Always look at the actual contact sheet: don't assume a folder is clean because its
  name matches the franchise.
- Franchises with crossover appearances (e.g. Pikmin showing up in Super Smash Bros. wallpapers) will
  have their pool diluted with generic ensemble-cast images where the target franchise is barely
  visible; a handful of these as flavor items is fine, but prioritize images that actually feature the
  franchise's own characters front and center.
- Keep the box mechanics untouched unless asked: `HIDDEN_CHANCE = 0.05` (independent per draw), box size
  equals `series.items.length` (currently 30 for every series — the code already reads this dynamically,
  it does not need to be told the count).
