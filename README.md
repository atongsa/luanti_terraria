# Luanti Terraria-Inspired 3D Game

A 3D voxel sandbox adventure game inspired by Terraria, built on the Luanti (formerly Minetest) engine.

**Important legal note**: This is an original game *inspired by* Terraria's gameplay loop, progression, biomes, and systems. It will **not** copy Terraria's assets, names, music, exact art, or proprietary content. All names, textures, models, and lore will be original.

## Status

Day 13 complete: Basic NPC — Wayseer (Guide equivalent, original name/design). Tall standing figure that appears near the surface. Right-click to open a simple dialog formspec with random helpful tips. Friendly (cannot be damaged). Use `/spawnwayseer` for testing or wait for natural spawn on first join. Previous features (Gloomseer boss, ranged weapons, equipment/armor, biomes/ores, gelblob combat, day/night, crafting, tools, physics, basic nodes) remain in place.

See [OUTLINE.md](OUTLINE.md) for the full plan and 30-day roadmap.
See [PROGRESS.md](PROGRESS.md) for daily logs.

## How to test

1. Clone this repo into your Luanti `games/` directory (or symlink).
2. Rename the folder to `luanti_terraria` if needed.
3. Launch Luanti, select the game, create a new world.
4. It should generate a layered world with varying biomes: forest (turf + occasional trees), desert (sand), snow. Underground has cragstone with early ores (copral near surface, others deeper). Caves still present.
5. Movement should feel snappier with higher jumps and floatier gravity. Falling more than ~8 blocks deals custom damage (reduced if armor equipped).
6. Dig timber and craft a Craftbench (2x2 timber) or `/giveme crafting:craftbench`. Place it and right-click to open the 3x3 crafting grid. Craft tools from timber/cragstone/soil. Craft hide armor and gel charm from gel residue (drop from gelblobs). Craft timberbow (timber) and pointed arrows (cragstone + timber, yields 8). Craft Gloom Lens from gel residue + cragstone.
7. Give yourself tools with `/giveme items:cragpick` (or timberaxe, soilscoop, shortblade) and confirm they dig the matching nodes at reasonable speeds and lose durability. Ores dig with cragpick.
8. Observe the day/night cycle: lighting on the surface changes from bright day to dark night. Use `/time` to view current time of day, or `/time 0.5` (noon) / `/time 0` (midnight) to jump the clock. Confirm sky, sun, and stars appear appropriately.
9. Test combat: `/spawnblob` to spawn a gelblob. It hops toward you and damages on close contact. Punch it (preferably with the shortblade) until it dies and drops gel residue. Confirm knockback and no Lua errors.
10. Test equipment: `/giveme items:hide_tunic` (or other hide pieces / gel_charm). Use `/equip` to open the equipment formspec. Place matching armor in the correct slots (head/chest/legs/feet/accessories). Defense total is shown. Take damage from a gelblob or a fall and confirm reduced damage. Confirm no Lua errors in the console.
11. Test ranged: `/giveme items:timberbow` and `/giveme items:pointed_arrow 16` (or craft them). Wield the timberbow and left-click/use it while having arrows in inventory. An arrow projectile should fly in your look direction, hit a gelblob (damaging it via punch logic) or a wall (disappear), and consume one arrow + wear the bow. Confirm no Lua errors.
12. Test first boss: Craft or `/giveme items:gloom_lens`. At night (`/time 0` or wait), use the lens to summon the Gloomseer (large floating cube). It will dash at you, deal contact damage, spawn gelblob minions, and switch to a faster phase 2 when damaged enough. Defeat it for gel residue + Gloom Shard. Alternatively use `/spawngloomseer`. Confirm phase change message, drops, and no Lua errors.
13. Test NPC: Use `/spawnwayseer` or join a new world (natural spawn after a few seconds near surface). Right-click the tall brown cube to open the Wayseer dialog formspec with a random tip. Confirm it is friendly (punching shows a chat message and does not kill it). Confirm no Lua errors.

## Goals

- Procedural 3D world with layered biomes (surface → underground → deep caverns → underworld)
- Exploration, building, combat, boss progression
- Crafting, NPCs, events, hardmode-style progression
- Multiplayer support (native to Luanti)
- Fully moddable with Lua

## Tech Stack

- Engine: Luanti (latest stable)
- Scripting: Lua
- Map generation: Custom Lua mapgen + engine mapgens
- Assets: Original voxel art / textures

## License

To be decided (likely LGPL or MIT for code, CC for assets).
