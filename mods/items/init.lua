-- Items mod
-- Day 5: Basic tools - cragpick (pickaxe), timberaxe (axe), soilscoop (shovel), shortblade (sword)
-- With durability (uses) and proper groupcaps matching node groups
-- Day 10: Basic armor and accessory items (hide set + gel charm)
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

-- Day 10: Basic armor pieces (hide set from gel residue) + one accessory
-- Defense value stored in groups for the equipment system to read
local function register_armor(name, desc, inventory_image, slot, defense)
    minetest.register_tool("items:" .. name, {
        description = desc .. " (Defense: " .. defense .. ")",
        inventory_image = inventory_image,
        groups = {armor = 1, armor_slot = slot, defense = defense},
        tool_capabilities = {
            full_punch_interval = 1.0,
            damage_groups = {fleshy = 1},
        },
    })
    core.log("action", "[items] Registered armor items:" .. name .. " (slot=" .. slot .. ", def=" .. defense .. ")")
end

register_armor("hide_cap", "Hide Cap", "items_hide_cap.png", "head", 1)
register_armor("hide_tunic", "Hide Tunic", "items_hide_tunic.png", "chest", 2)
register_armor("hide_leggings", "Hide Leggings", "items_hide_leggings.png", "legs", 1)
register_armor("hide_boots", "Hide Boots", "items_hide_boots.png", "feet", 1)

-- Simple accessory (can go in either accessory slot)
register_armor("gel_charm", "Gel Charm", "items_gel_charm.png", "accessory", 1)

core.log("action", "[items] Basic tools and early armor/accessories registered")
