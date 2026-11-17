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

---

## 2026-11-16 — Day 1: Finish game skeleton

**Status**: Done (pending user confirmation of load in Luanti)

**What was done**:
- Expanded the mod structure with placeholder mods matching the planned architecture: nodes, mapgen, items, entities, crafting, progression, ui, biomes.
- Each has mod.conf and a minimal init.lua that logs on load.
- Added .gitignore for common files and worlds/.
- Updated README.md with testing instructions and current status.
- Core skeleton is now more complete and ready for Day 2 node work.

**Commits / files**:
- mods/nodes/mod.conf, mods/nodes/init.lua
- mods/mapgen/mod.conf, mods/mapgen/init.lua
- mods/items/mod.conf, mods/items/init.lua
- mods/entities/mod.conf, mods/entities/init.lua
- mods/crafting/mod.conf, mods/crafting/init.lua
- mods/progression/mod.conf, mods/progression/init.lua
- mods/ui/mod.conf, mods/ui/init.lua
- mods/biomes/mod.conf, mods/biomes/init.lua
- .gitignore
- README.md (updated)
- PROGRESS.md (this update)

**Notes / blockers**:
- Please clone/pull the latest into your Luanti games/ folder and confirm it loads an empty world without errors. Once confirmed, Day 1 is fully closed.
- All names and content remain original.

**Next**:
- Day 2: Implement basic nodes (dirt, grass, stone, wood, leaves) + simple original textures.

---

## 2026-11-17 — Day 2: Implement basic nodes

**Status**: Done (textures are placeholders; nodes registered)

**What was done**:
- Registered five basic nodes with original names in `mods/nodes/init.lua`:
  - `nodes:soil` (dirt equivalent)
  - `nodes:turf` (grass equivalent, with different top texture)
  - `nodes:cragstone` (stone equivalent)
  - `nodes:timber` (wood equivalent)
  - `nodes:foliage` (leaves equivalent, with waving and light param)
- Added appropriate groups for mining/digging (crumbly, cracky, choppy, snappy, etc.).
- Created `mods/nodes/textures/README.md` documenting the expected original 16x16 PNG texture filenames.
- Nodes will appear in creative inventory (via groups) and can be placed once the game loads.

**Commits / files**:
- mods/nodes/init.lua (updated with node registrations)
- mods/nodes/textures/README.md (new)
- PROGRESS.md (this update)

**Notes / blockers**:
- Textures are not yet committed (binary PNG upload limitation in this workflow). Add the PNG files listed in textures/README.md for proper visuals; until then, missing-texture (pink) will show. Simple colored placeholders are fine for testing.
- Please test in Luanti: the nodes should be placeable (use creative mode or /giveme nodes:soil etc.). Confirm no Lua errors on load.
- All content original; no Terraria names or assets.

**Next**:
- Day 3: Custom mapgen — surface + underground + basic caves (Terraria-style vertical layers).
