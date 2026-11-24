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

**Status**: Done

**What was done**:
- Registered five basic nodes with original names in `mods/nodes/init.lua`:
  - `nodes:soil` (dirt equivalent)
  - `nodes:turf` (grass equivalent, with different top texture)
  - `nodes:cragstone` (stone equivalent)
  - `nodes:timber` (wood equivalent)
  - `nodes:foliage` (leaves equivalent, with waving and light param)
- Added appropriate groups for mining/digging (crumbly, cracky, choppy, snappy, etc.).
- Created simple solid-color 16x16 PNG texture placeholders in `mods/nodes/textures/` (brown soil, green turf, gray stone, dark brown timber, green foliage).
- Added `mods/nodes/textures/README.md` documenting the texture files.
- Nodes will appear in creative inventory (via groups) and can be placed once the game loads. Textures are basic solid colors for now (can be improved later with more detailed original art).

**Commits / files**:
- mods/nodes/init.lua (updated with node registrations)
- mods/nodes/textures/README.md
- mods/nodes/textures/nodes_soil.png
- mods/nodes/textures/nodes_turf.png
- mods/nodes/textures/nodes_cragstone.png
- mods/nodes/textures/nodes_timber.png
- mods/nodes/textures/nodes_foliage.png
- PROGRESS.md (this update)
- README.md (status updated)

**Notes / blockers**:
- Textures are simple solid colors (original). Improve with more detailed pixel art in later days if desired.
- Please test in Luanti: the nodes should be placeable (use creative mode or /giveme nodes:soil etc.) and show solid colors. Confirm no Lua errors on load.
- All content original; no Terraria names or assets.

**Next**:
- Day 3: Custom mapgen — surface + underground + basic caves (Terraria-style vertical layers).

---

## 2026-11-18 — Day 3: Custom mapgen

**Status**: Done

**What was done**:
- Implemented custom mapgen in `mods/mapgen/init.lua` using singlenode base + `register_on_generated`.
- Surface layer: turf (nodes:turf) at variable height (~Y=8 with simple sine/cosine variation), soil (nodes:soil) for a few blocks below.
- Underground: cragstone (nodes:cragstone) filling the rest of the volume.
- Basic caves: random spherical/void carves in the stone layer for underground exploration.
- Updated `mods/mapgen/mod.conf` to depend on the nodes mod.
- Disabled water for now (very low water_level) to keep the focus on solid layers.

**Commits / files**:
- mods/mapgen/mod.conf (depends on nodes)
- mods/mapgen/init.lua (full custom layered generator + cave carves)
- PROGRESS.md (this update)
- README.md (status updated)

**Notes / blockers**:
- Generation is fully original (simple height function + random cave blobs). No Terraria assets or names.
- Please test in Luanti: create a new world. You should see a rolling surface of turf/soil over stone, with occasional cave openings underground. Confirm no Lua errors and that lighting looks reasonable.
- Trees, biomes, ores, and more sophisticated noise will come in later days.

**Next**:
- Day 4: Player physics tuning (speed, jump, gravity, fall damage) for Terraria-like 3D feel.

---

## 2026-11-19 — Day 4: Player physics tuning

**Status**: Done

**What was done**:
- Tuned player physics in `mods/core/init.lua` for a Terraria-like 3D platforming feel:
  - Movement speed multiplier: 1.2
  - Jump height multiplier: 1.8
  - Gravity multiplier: 0.7 (floatier jumps)
  - Enabled improved movement where available.
- Implemented custom fall damage: cancels engine fall damage and applies scaled damage after a safe fall of ~8 blocks (2 damage per additional block).
- Applied on player join; tracks velocity and position in globalstep for landing detection.
- Logs applied overrides and fall damage events.

**Commits / files**:
- mods/core/init.lua (physics overrides + custom fall damage)
- PROGRESS.md (this update)
- README.md (status updated)

**Notes / blockers**:
- Physics values are starting points for a responsive platforming feel; can be fine-tuned after playtesting.
- Custom fall damage is simple and original. Engine fall damage is suppressed.
- Please test in Luanti: jump height and movement should feel snappier/floatier than default, and falling more than ~8 blocks should deal damage. Confirm no Lua errors.
- All content original.

**Next**:
- Day 5: Basic tools (pickaxe, axe, shovel, sword) + durability + mining groups.

---

## 2026-11-20 — Day 5: Basic tools

**Status**: Done

**What was done**:
- Registered four basic tools with original names in `mods/items/init.lua`:
  - `items:cragpick` (pickaxe) — digs cracky (cragstone)
  - `items:timberaxe` (axe) — digs choppy (timber)
  - `items:soilscoop` (shovel) — digs crumbly (soil/turf)
  - `items:shortblade` (sword) — digs snappy (foliage) + higher fleshy damage
- Each has tool_capabilities with groupcaps matching the node groups from Day 2, durability via `uses` (40–50), and appropriate punch damage.
- Updated `mods/items/mod.conf` to depend on nodes.
- Added `mods/items/textures/README.md` documenting solid-color inventory texture placeholders (items_cragpick.png etc.). Actual PNG files can be added as simple solid colors matching the style of node textures.
- Tools are available via creative inventory or `/giveme items:cragpick` etc. and will correctly mine the matching node types.

**Commits / files**:
- mods/items/init.lua (tool registrations)
- mods/items/mod.conf (depends = nodes)
- mods/items/textures/README.md
- PROGRESS.md (this update)
- README.md (status updated)

**Notes / blockers**:
- Texture PNGs are referenced but not yet committed as binary files in this run; they will show as missing-texture until simple 16x16 solid-color PNGs are added (or use the README as guide). Functionality of digging/durability is complete.
- Please test in Luanti: give yourself the tools and confirm they dig the correct nodes at reasonable speeds, lose durability, and deal punch damage. Confirm no Lua errors.
- All content original; no Terraria names or assets.
- Crafting the tools is planned for Day 6.

**Next**:
- Day 6: Simple crafting system + workbench.

---

## 2026-11-21 — Day 6: Simple crafting system + workbench

**Status**: Done

**What was done**:
- Implemented a simple crafting system in `mods/crafting/init.lua` with a placeable `crafting:craftbench` node.
- Craftbench provides a 3x3 crafting grid + preview via formspec and inventory callbacks (using `minetest.get_craft_result`).
- Registered shaped recipes:
  - Craftbench itself (2x2 timber) — craftable in player inventory.
  - Tools from Day 5: cragpick, timberaxe, soilscoop, shortblade (require the 3x3 grid).
- Updated `mods/crafting/mod.conf` to depend on nodes and items.
- Node uses existing timber texture as placeholder; groups allow chopping with timberaxe.

**Commits / files**:
- mods/crafting/mod.conf (depends = nodes,items)
- mods/crafting/init.lua (craftbench node + recipes + inventory logic)
- PROGRESS.md (this update)
- README.md (status updated)

**Notes / blockers**:
- Crafting logic is basic and original. Preview updates on inventory changes; taking the result consumes inputs.
- Please test in Luanti: dig some timber, craft a craftbench (or /giveme crafting:craftbench), place it, right-click to open, and craft the tools from stone/soil/timber. Confirm recipes work and no Lua errors.
- All content original; no Terraria names or assets.
- Player 2x2 crafting grid (if available) can make the craftbench; tools need the station.

**Next**:
- Day 7: Day/night cycle + basic time-of-day lighting.

---

## 2026-11-22 — Day 7: Day/night cycle + basic time-of-day lighting

**Status**: Done

**What was done**:
- Enabled and configured the day/night cycle in `mods/core/init.lua`:
  - Set `time_speed` to 72 (full cycle ≈ 20 minutes real time).
  - Start new worlds / first join near sunrise (0.25).
  - Configured basic sky, sun, moon, and stars for proper time-of-day visual lighting (engine handles sunlight intensity and fade automatically).
- Added `/time` chat command for testing (get current time or set to a value 0.0–1.0).
- Surface lighting now changes with the cycle; underground remains dark without light sources (as expected).

**Commits / files**:
- mods/core/init.lua (day/night cycle setup + sky + /time command)
- PROGRESS.md (this update)
- README.md (status updated)

**Notes / blockers**:
- Lighting is the engine's standard time-of-day system (sunlight on surface, darkness at night and underground). No custom light sources or advanced shaders yet.
- Please test in Luanti: create/join a world, observe the sky and lighting change over time (or use `/time 0.5` for noon, `/time 0` for midnight). Confirm no Lua errors and that the cycle progresses.
- All content original; no Terraria names or assets.
- Enemies that spawn based on time of day will come in Day 8.

**Next**:
- Day 8: First enemy (slime-like) + basic combat (melee hit detection).

---

## 2026-11-23 — Day 8: First enemy (gelblob) + basic combat

**Status**: Done

**What was done**:
- Registered the first enemy `entities:gelblob` (original slime-like hopping green blob) in `mods/entities/init.lua`.
- Basic AI: periodically hops toward nearby players (or idles randomly); damages player on close contact with cooldown and knockback.
- Basic melee combat: `on_punch` detects hits, applies damage from the wielded tool's fleshy damage groups (shortblade hits harder), applies knockback, and removes the entity at 0 HP, dropping `entities:gel_residue`.
- Added testing chat command `/spawnblob` to spawn one near the player.
- Updated `mods/entities/mod.conf` to depend on nodes and items.
- Added placeholder textures note in `mods/entities/textures/README.md` (currently uses green turf texture for the cube visual).

**Commits / files**:
- mods/entities/mod.conf (depends = nodes,items)
- mods/entities/init.lua (gelblob entity, residue item, spawn command, combat logic)
- mods/entities/textures/README.md
- PROGRESS.md (this update)
- README.md (status updated)

**Notes / blockers**:
- Visual is a simple green cube using existing turf texture (original placeholder). Can be replaced with dedicated pixel art later.
- Spawning is manual via `/spawnblob` for testing; automatic night spawns or surface ABMs can be added later.
- Please test in Luanti: use `/spawnblob`, approach the hopping blob (it should damage you on contact), then punch it with the shortblade (or bare hands) until it dies and drops gel residue. Confirm knockback, damage scaling, and no Lua errors.
- All content original; no Terraria names or assets.

**Next**:
- Day 9: Expand mapgen — surface biomes (forest, desert, snow), ore distribution matching early Terraria tiers.

---

## 2026-11-24 — Day 9: Expand mapgen with biomes and ores

**Status**: Done

**What was done**:
- Expanded custom mapgen in `mods/mapgen/init.lua` with three surface biomes selected via simple large-scale noise:
  - Forest: turf surface + soil under, occasional simple trees (timber trunk + foliage canopy).
  - Desert: sand surface and underlayer (dune-like height variation).
  - Snow: snow surface over soil.
- Added early-tier ore nodes in `mods/nodes/init.lua` with original names matching progression feel:
  - `nodes:copral_ore` (copper-like, shallow, higher chance near surface).
  - `nodes:ferrite_ore` (iron-like, mid-depth).
  - `nodes:argentite_ore` (silver-like, deeper).
  - `nodes:aurite_ore` (gold-like, deepest early).
- Ores replace stone probabilistically by depth during generation; caves still carve through stone and ores.
- Updated texture README to document new placeholder textures needed (sand, snow, ore variants).
- All biomes and ores use original names and simple implementations.

**Commits / files**:
- mods/nodes/init.lua (added sand, snow, copral/ferrite/argentite/aurite ore nodes)
- mods/mapgen/init.lua (biome selection, trees in forest, depth-based ore placement, updated cave carving)
- mods/nodes/textures/README.md (updated with new texture names)
- README.md (status and testing instructions updated)
- PROGRESS.md (this update)

**Notes / blockers**:
- New nodes currently use existing solid-color textures as placeholders (sand/soil brown, snow/turf green, ores/stone gray). Dedicated original textures can be added later.
- Biome boundaries are soft via noise; trees are basic single-column with canopy. Ore rates are starting values for early exploration.
- Please test in Luanti: generate a new world and explore to see forest trees, desert sand areas, snow regions, and mine underground for the four early ores at appropriate depths. Confirm no Lua errors and that tools dig the new nodes.
- All content original; no Terraria names or assets.

**Next**:
- Day 10: Inventory & equipment slots (armor + accessories).
