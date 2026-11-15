# Project Outline: Luanti Terraria-Inspired 3D Game

## 1. Vision

Create a fully playable 3D voxel sandbox adventure game on Luanti that captures the spirit of Terraria:

- Exploration of a vast, layered world
- Building and crafting
- Combat against monsters and multi-phase bosses
- Clear progression (pre-hardmode → hardmode equivalent)
- Town NPCs, events, and secrets

**Not a 1:1 copy.** All content will be original (names, art, lore, exact mechanics where needed for 3D).

## 2. Core Pillars

1. **World** – Procedural generation with distinct vertical layers and biomes.
2. **Progression** – Tools, armor, weapons, and bosses that unlock new areas/content.
3. **Combat & Movement** – Responsive 3D platforming + combat (jumps, dashes, weapons).
4. **Building & Crafting** – Flexible building + deep crafting trees.
5. **Social / NPCs** – Town system with happiness, housing, and unique NPCs.
6. **Events & Replayability** – Invasions, blood moons, hardmode transformation.

## 3. Technical Architecture (Luanti)

```
luanti_terraria/                  # Game folder (place in games/)
├── game.conf
├── menu/                      # Main menu assets
├── mods/
│   ├── core/                   # Core systems (player, inventory helpers)
│   ├── mapgen/                 # Custom layered map generation
│   ├── nodes/                  # All blocks / ores / materials
│   ├── items/                  # Tools, weapons, armor, consumables
│   ├── entities/               # Mobs, bosses, projectiles, NPCs
│   ├── crafting/               # Recipes and stations
│   ├── progression/            # Hardmode flags, boss kills, world state
│   ├── ui/                     # Custom formspecs / HUD
│   ├── biomes/                 # Biome definitions & decorations
│   └── ... (more as needed)
└── textures/                   # Original textures
```

Key Luanti features we will use:
- Custom mapgen via Lua (or ABMs + emerge)
- Entity system for mobs/bosses
- Node definitions + groups
- Crafting API
- Formspecs for inventory / NPC dialogs
- World metadata / player metadata for progression flags

## 4. High-Level Content Scope (MVP → Full)

### Phase A – Foundation (Days 1-8)
- Game skeleton + basic nodes
- Simple layered mapgen (surface, dirt, stone, caves)
- Player movement tuned for 3D platforming
- Basic tools & crafting
- Day/night + basic enemies

### Phase B – Core Loop (Days 9-16)
- Full biome layers + ores
- Weapon classes (melee, ranged, magic)
- First bosses (2-3)
- Basic NPCs + housing
- Inventory & equipment system polish

### Phase C – Progression & Depth (Days 17-24)
- Hardmode trigger + world transformation
- More biomes, harder enemies, new ores
- Additional bosses + events
- Town happiness / NPC AI improvements
- Building convenience (smart cursor, more blocks)

### Phase D – Polish & Content (Days 25-30)
- UI/UX polish, sounds, particles
- Final bosses / endgame content
- Multiplayer testing & balancing
- Documentation + ContentDB packaging
- Playtesting feedback loop

## 5. 30-Day Task Breakdown

Each day has **one focused task**. Complete it, log in PROGRESS.md, commit, move on.

### Week 1 – Foundation
| Day | Task |
|-----|------|
| 1 | Create game skeleton (`game.conf`, basic mod structure, README already done). Load empty world in Luanti. |
| 2 | Implement basic nodes: dirt, grass, stone, wood, leaves + simple textures. |
| 3 | Custom mapgen: flat-ish surface + underground stone layer + basic caves. |
| 4 | Player physics tuning (speed, jump, gravity, fall damage) for Terraria-like feel in 3D. |
| 5 | Basic tools (pickaxe, axe, shovel, sword) + durability + mining groups. |
| 6 | Simple crafting system + workbench. |
| 7 | Day/night cycle + basic time-of-day lighting. |
| 8 | First enemy (slime-like) + basic combat (melee hit detection). |

### Week 2 – Core Systems
| Day | Task |
|-----|------|
| 9 | Expand mapgen: surface biomes (forest, desert, snow), ore distribution (copper/iron/gold equivalents). |
| 10 | Inventory & equipment slots (armor + accessories). |
| 11 | Ranged weapon (bow + arrows) + projectile entities. |
| 12 | First boss (Eye-of-Cthulhu inspired, original design) + spawn conditions. |
| 13 | Basic NPC (Guide equivalent) + simple dialog formspec. |
| 14 | Housing system (room detection for NPCs). |
| 15 | Magic weapon prototype + mana system. |
| 16 | World progression flags (bosses defeated stored in world meta). |

### Week 3 – Depth & Hardmode
| Day | Task |
|-----|------|
| 17 | Underworld / deep layer mapgen + lava. |
| 18 | Hardmode trigger (after Wall-of-Flesh inspired boss). |
| 19 | Hardmode ores + new tools/weapons. |
| 20 | Invasion / event system skeleton (Blood Moon style). |
| 21 | Second major boss + multi-phase AI. |
| 22 | Town NPC happiness / biome preferences. |
| 23 | More building blocks + painting / furniture. |
| 24 | Cave decorations, background walls, ambient effects. |

### Week 4 – Polish & Ship
| Day | Task |
|-----|------|
| 25 | Sound effects + basic music hooks. |
| 26 | Particle effects, death animations, screen shake. |
| 27 | UI polish (HUD, inventory, boss health bars). |
| 28 | Multiplayer testing + basic server config. |
| 29 | Balance pass + bug fixing from playtests. |
| 30 | Package for ContentDB, final docs, v0.1 release tag. |

## 6. Daily Workflow

1. Read the day's task from this file.
2. Implement in the corresponding mod.
3. Test in singleplayer.
4. Commit with clear message.
5. Append entry to `PROGRESS.md` (date, task, what was done, blockers, next notes).
6. Push to GitHub.

## 7. Success Criteria for Day 30

- Playable singleplayer experience with at least:
  - Layered world + 3+ biomes
  - Full tool progression to hardmode
  - 3+ bosses
  - Working town NPCs
  - Crafting + combat loop
- Clean mod structure that others can extend
- Documented how to run and contribute

## 8. Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| Scope too large | Strict daily tasks; cut content if behind |
| Mapgen performance | Use engine mapgen helpers + Lua only for custom layers |
| Boss AI complexity | Start simple state machines, iterate |
| Legal / IP | Never use Terraria names/assets; keep original |
| Learning Lua + Luanti API | Allocate early days to reading docs + small experiments |

---

**Next action**: Start Day 1 — create the game skeleton.
