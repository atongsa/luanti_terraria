-- Items mod
-- Day 5: Basic tools - cragpick (pickaxe), timberaxe (axe), soilscoop (shovel), shortblade (sword)
-- With durability (uses) and proper groupcaps matching node groups
-- All names and designs original

core.log("action", "[items] Items mod loaded")

-- Helper to register a basic tool
local function register_basic_tool(name, desc, inventory_image, groupcaps, damage)
    minetest.register_tool("items:" .. name, {
        description = desc,
        inventory_image = inventory_image,
        tool_capabilities = {
            full_punch_interval = 1.0,
            max_drop_level = 0,
            groupcaps = groupcaps,
            damage_groups = {fleshy = damage or 2},
        },
        groups = {[name] = 1},
        sound = {breaks = "default_tool_breaks"},
    })
    core.log("action", "[items] Registered tool items:" .. name)
end

-- Cragpick (pickaxe) - digs cracky (stone)
register_basic_tool("cragpick", "Cragpick",
    "items_cragpick.png",
    {
        cracky = {times = {[3] = 1.50}, uses = 40, maxlevel = 1},
    },
    3
)

-- Timberaxe (axe) - digs choppy (wood)
register_basic_tool("timberaxe", "Timberaxe",
    "items_timberaxe.png",
    {
        choppy = {times = {[2] = 1.40}, uses = 40, maxlevel = 1},
    },
    3
)

-- Soilscoop (shovel) - digs crumbly (soil/turf)
register_basic_tool("soilscoop", "Soilscoop",
    "items_soilscoop.png",
    {
        crumbly = {times = {[3] = 0.50}, uses = 40, maxlevel = 1},
    },
    2
)

-- Shortblade (sword) - digs snappy (leaves/foliage) + higher punch damage
register_basic_tool("shortblade", "Shortblade",
    "items_shortblade.png",
    {
        snappy = {times = {[3] = 0.40}, uses = 50, maxlevel = 1},
    },
    5
)

core.log("action", "[items] Basic tools registered with durability and mining groups")
