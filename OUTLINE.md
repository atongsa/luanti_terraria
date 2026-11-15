# Project Outline: Luanti Terraria-Inspired 3D Game

## 1. Vision

Create a fully playable 3D voxel sandbox adventure game on Luanti that **closely recreates Terraria's systems, progression, bosses, weapons, and map structure**, but with completely original names and original visual design.

**Core rule:**
- Mechanisms, boss fight patterns, weapon classes, map layers, progression gates, events, NPC systems → copy Terraria as closely as possible.
- Names, art, textures, models, sounds, dialogue, lore → 100% original.

This gives the authentic Terraria gameplay feel in 3D while staying legally clean.

## 2. Core Pillars (Terraria systems adapted to 3D)

1. **World** – Layered map (Surface → Underground → Cavern → Underworld) + biomes that transform after hardmode.
2. **Progression** – Exact same style of tool/armor tiers, boss-gated progression, and world changes.
3. **Combat & Movement** – Responsive platforming + classless combat (melee / ranged / magic / summoner feel).
4. **Building & Crafting** – Flexible building + deep crafting trees with stations.
5. **Social / NPCs** – Housing system, NPC happiness, unique NPCs that move in after conditions are met.
6. **Events & Replayability** – Blood Moon style nights, invasions, hardmode transformation, boss summoning items.

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

## 4. High-Level Content Scope (MVP → Full)

### Phase A – Foundation (Days 1-8)
- Game skeleton + basic nodes
- Layered mapgen matching Terraria's vertical structure
- Player movement tuned for platforming feel
- Basic tools & crafting
- Day/night + basic enemies (slime equivalents)

### Phase B – Core Loop (Days 9-16)
- Full biome layers + ores matching Terraria tiers
- Weapon classes (melee, ranged, magic)
- First major bosses (Eye-of-Cthulhu style → original name & design)
- Basic NPCs + housing system
- Inventory & equipment

### Phase C – Progression & Depth (Days 17-24)
- Underworld + Wall-of-Flesh style boss → hardmode trigger
- Hardmode ores, new weapons, biome transformation
- Mechanical bosses style fights
- Invasion / Blood Moon style events
- Town happiness system

### Phase D – Polish & Ship (Days 25-30)
- More content, particles, sounds
- UI polish (boss health bars, etc.)
- Multiplayer testing
- Balance + packaging for ContentDB

## 5. 30-Day Task Breakdown

Each day has **one focused task**. Complete it, log in PROGRESS.md, commit, move on.

### Week 1 – Foundation
| Day | Task |
|-----|------|
| 1 | Create game skeleton (`game.conf`, basic mod structure). Load empty world in Luanti. |
| 2 | Implement basic nodes: dirt, grass, stone, wood, leaves + simple original textures. |
| 3 | Custom mapgen: surface + underground + basic caves (Terraria-style vertical layers). |
| 4 | Player physics tuning (speed, jump, gravity, fall damage) for Terraria-like 3D feel. |
| 5 | Basic tools (pickaxe, axe, shovel, sword) + durability + mining groups. |
| 6 | Simple crafting system + workbench. |
| 7 | Day/night cycle + basic time-of-day lighting. |
| 8 | First enemy (slime-like) + basic combat (melee hit detection). |

### Week 2 – Core Systems
| Day | Task |
|-----|------|
| 9 | Expand mapgen: surface biomes (forest, desert, snow), ore distribution matching early Terraria tiers. |
| 10 | Inventory & equipment slots (armor + accessories). |
| 11 | Ranged weapon (bow + arrows) + projectile entities. |
| 12 | First boss (Eye-of-Cthulhu style mechanics, original name + design) + spawn conditions. |
| 13 | Basic NPC (Guide equivalent, original name) + simple dialog formspec. |
| 14 | Housing system (room detection for NPCs). |
| 15 | Magic weapon prototype + mana system. |
| 16 | World progression flags (bosses defeated stored in world meta). |

### Week 3 – Depth & Hardmode
| Day | Task |
|-----|------|
| 17 | Underworld / deep layer mapgen + lava. |
| 18 | Hardmode trigger boss (Wall-of-Flesh style mechanics, original name) + world transformation. |
| 19 | Hardmode ores + new tools/weapons. |
| 20 | Invasion / event system skeleton (Blood Moon style). |
| 21 | Second major boss (multi-phase, mechanical style) + AI. |
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
2. Implement in the corresponding mod (mechanics close to Terraria, original names/design).
3. Test in singleplayer when possible.
4. Commit with clear message ("Day N: ...").
5. Append entry to `PROGRESS.md`.
6. Push to GitHub.

## 7. Success Criteria for Day 30

- Playable singleplayer experience with:
  - Layered world matching Terraria vertical structure + multiple biomes
  - Tool/armor progression through early hardmode
  - At least 3 major bosses with Terraria-style fight patterns (original names)
  - Working town NPCs + housing
  - Crafting + combat loop that feels familiar
- Clean mod structure that can keep growing after Day 30

## 8. Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| Scope too large | Strict daily tasks; cut or simplify if behind |
| Mapgen performance | Use engine helpers + Lua only where needed |
| Boss AI complexity | Start with simple state machines, iterate |
| Legal / IP | Never use Terraria names, assets, music, or exact art |
| 3D adaptation | Some 2D mechanics need smart 3D redesign (still keep the spirit) |

---

**Locked direction (user confirmed):**  
Copy Terraria's bosses, weapons, mechanisms, map structure, and progression as closely as possible.  
Use only original names and original visual design.
