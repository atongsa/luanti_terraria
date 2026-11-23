# Luanti Terraria-Inspired 3D Game

A 3D voxel sandbox adventure game inspired by Terraria, built on the Luanti (formerly Minetest) engine.

**Important legal note**: This is an original game *inspired by* Terraria's gameplay loop, progression, biomes, and systems. It will **not** copy Terraria's assets, names, music, exact art, or proprietary content. All names, textures, models, and lore will be original.

## Status

Day 8 complete: First enemy (gelblob - slime-like hopping blob) + basic melee combat added. Use `/spawnblob` to test. The gelblob hops toward you, damages on contact, and can be punched with tools (shortblade deals more damage). Drops gel residue on death. Previous features (day/night, crafting, tools, physics, mapgen, nodes) remain in place.

See [OUTLINE.md](OUTLINE.md) for the full plan and 30-day roadmap.
See [PROGRESS.md](PROGRESS.md) for daily logs.

## How to test

1. Clone this repo into your Luanti `games/` directory (or symlink).
2. Rename the folder to `luanti_terraria` if needed.
3. Launch Luanti, select the game, create a new world.
4. It should generate a layered world: rolling turf surface, soil layer, stone underground, and some cave voids.
5. Movement should feel snappier with higher jumps and floatier gravity. Falling more than ~8 blocks deals custom damage.
6. Dig timber and craft a Craftbench (2x2 timber) or `/giveme crafting:craftbench`. Place it and right-click to open the 3x3 crafting grid. Craft tools from timber/cragstone/soil.
7. Give yourself tools with `/giveme items:cragpick` (or timberaxe, soilscoop, shortblade) and confirm they dig the matching nodes at reasonable speeds and lose durability.
8. Observe the day/night cycle: lighting on the surface changes from bright day to dark night. Use `/time` to view current time of day, or `/time 0.5` (noon) / `/time 0` (midnight) to jump the clock. Confirm sky, sun, and stars appear appropriately.
9. Test combat: `/spawnblob` to spawn a gelblob. It hops toward you and damages on close contact. Punch it (preferably with the shortblade) until it dies and drops gel residue. Confirm knockback and no Lua errors.
10. Confirm no Lua errors in the console. Nodes, tools, and craftbench are placeable/usable.

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
