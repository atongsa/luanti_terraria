# Progress Log

Daily progress for the Luanti Terraria-inspired project.

Format for each entry:

```
## YYYY-MM-DD — Day N: Task title

**Status**: Done / Partial / Blocked

**What was done**:
- ...

**Commits / files**:
- ...

**Notes / blockers**:
- ...

**Next**:
- ...
```

---

## 2026-11-15 — Day 0: Project Kickoff

**Status**: Done

**What was done**:
- Confirmed Luanti (formerly Minetest) is a suitable open-source voxel engine for a 3D Terraria-inspired game.
- Clarified legal boundary: original content only, inspired by mechanics/progression, no Terraria assets or names.
- Created empty repository structure and initial files.
- Wrote full project OUTLINE.md with vision, architecture, and 30-day daily task plan.
- Initialized this PROGRESS.md log.

**Commits / files**:
- README.md
- OUTLINE.md
- PROGRESS.md

**Notes / blockers**:
- Repository was empty; now bootstrapped.
- Next real work starts with Day 1 (game skeleton).

**Next**:
- Day 1: Create game skeleton (`game.conf`, basic mod folders, make it loadable in Luanti).

---

## 2026-11-15 — Day 1: Create game skeleton

**Status**: Partial (skeleton created, still needs testing in Luanti)

**What was done**:
- Added `game.conf` with basic game metadata.
- Created `mods/core/` with `mod.conf` and minimal `init.lua` that logs on load.
- Repo is now a valid (minimal) Luanti game structure.

**Commits / files**:
- game.conf
- mods/core/mod.conf
- mods/core/init.lua

**Notes / blockers**:
- To fully complete Day 1, clone/pull this repo into your Luanti `games/` folder (rename folder to something like `luanti_terraria`), start Luanti, and confirm the game appears and loads an empty world without errors.
- No nodes or mapgen yet — that is Day 2+.

**Next**:
- Day 2: Implement basic nodes (dirt, grass, stone, wood, leaves) + simple textures.
