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

## 2026-11-26 — Day 11: Ranged weapon (bow + arrows) + projectile entities

**Status**: Done

**What was done**:
- Registered ranged items in `mods/items/init.lua` with original names:
  - `items:timberbow` (bow tool with on_use that consumes arrows and fires projectiles)
  - `items:pointed_arrow` (stackable craftitem ammunition)
- Implemented projectile entity `entities:pointed_arrow` in `mods/entities/init.lua`:
  - Sprite visual (placeholder timber texture), flies in the fired direction with lifetime.
  - Detects solid node collisions (removes) and object collisions (damages players or punches gelblobs using fleshy damage).
  - Stores owner and damage; supports staticdata for persistence.
- Added shaped recipes in `mods/crafting/init.lua`:
  - Timberbow from timber (3x3 shape).
  - Pointed arrows from cragstone + timber (yields 8).
- Updated texture READMEs for inventory and entity placeholders.
- Bow applies wear on each shot; requires arrows in inventory to fire.

**Commits / files**:
- mods/items/init.lua (timberbow + pointed_arrow registration and on_use)
- mods/entities/init.lua (pointed_arrow projectile entity)
- mods/crafting/init.lua (bow and arrow recipes)
- mods/items/textures/README.md (updated)
- mods/entities/textures/README.md (updated)
- README.md (status + testing updated)
- PROGRESS.md (this update)

**Notes / blockers**:
- Arrow visual is a simple sprite using existing timber texture (original placeholder). Can be replaced with dedicated pixel art later.
- Projectile collision is radius-based and original. Damage to gelblobs reuses the existing on_punch logic.
- Please test in Luanti: craft or `/giveme` the timberbow and some pointed arrows, wield the bow and use it (left-click) to fire. Confirm an arrow flies in your look direction, hits a gelblob (damaging it) or a solid node (disappears), consumes one arrow, and the bow loses durability. Confirm no Lua errors.
- All content original; no Terraria names or assets.

**Next**:
- Day 12: First boss (Eye-of-Cthulhu style mechanics, original name + design) + spawn conditions.

---

## 2026-11-27 — Day 12: First boss (Gloomseer) + spawn conditions

**Status**: Done

**What was done**:
- Implemented the first boss `entities:gloomseer` (original name/design: large floating eye-like entity) in a new `mods/entities/boss.lua` (loaded from init.lua).
  - Phase 1: Hovers and periodically dashes toward the nearest player, contact damage, spawns gelblob minions.
  - Phase 2 (below half HP): Faster dashes, higher damage, visual change (larger, different placeholder texture), chat announcement.
  - On death: Drops gel residue + unique `entities:gloom_shard`, chat announcement.
- Added spawn conditions:
  - Craftable summon item `items:gloom_lens` (usable only at night; consumes and spawns the boss nearby).
  - Natural night spawn chance (low probability when night starts if a player is somewhat hurt).
  - Debug chat command `/spawngloomseer`.
- Added recipe for the Gloom Lens (gel residue + cragstone pattern) in crafting.
- Updated texture placeholder notes in entities and items READMEs.
- All names, mechanics presentation, and visuals original (cube placeholders).

**Commits / files**:
- mods/entities/boss.lua (new Gloomseer entity + drop + night spawn logic + command)
- mods/entities/init.lua (dofile the boss file)
- mods/items/init.lua (gloom_lens summon item with night check)
- mods/crafting/init.lua (gloom_lens recipe)
- mods/entities/textures/README.md (updated)
- mods/items/textures/README.md (updated)
- PROGRESS.md (this update)
- README.md (status + testing updated)

**Notes / blockers**:
- Boss visual is a large rotating cube using existing node textures as placeholders (gray phase 1, green phase 2). Can be replaced with dedicated original art later.
- AI is simple velocity-based dashes and hover (original implementation of classic eye-boss patterns). No advanced pathfinding yet.
- Natural spawn is a basic globalstep check; can be refined later.
- Please test in Luanti: craft or `/giveme items:gloom_lens`, wait for night (or `/time 0`), use the lens to summon. Fight the floating cube: it dashes, damages on contact, spawns gelblobs, switches to phase 2, and drops items on death. Also try `/spawngloomseer`. Confirm no Lua errors.
- All content original; no Terraria names or assets.

**Next**:
- Day 13: Basic NPC (Guide equivalent, original name) + simple dialog formspec.
