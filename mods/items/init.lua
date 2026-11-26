-- Items mod
-- Day 5: Basic tools - cragpick (pickaxe), timberaxe (axe), soilscoop (shovel), shortblade (sword)
-- With durability (uses) and proper groupcaps matching node groups
-- Day 10: Basic armor and accessory items (hide set + gel charm)
-- Day 11: Ranged weapon (timberbow) + pointed_arrow
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

-- Day 11: Ranged - timberbow + pointed_arrow
minetest.register_craftitem("items:pointed_arrow", {
    description = "Pointed Arrow",
    inventory_image = "items_pointed_arrow.png",
    groups = {arrow = 1},
    stack_max = 99,
})

minetest.register_tool("items:timberbow", {
    description = "Timberbow",
    inventory_image = "items_timberbow.png",
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level = 0,
        damage_groups = {fleshy = 1},  -- weak melee fallback
    },
    groups = {weapon = 1, ranged = 1},
    on_use = function(itemstack, user, pointed_thing)
        if not user or not user:is_player() then return itemstack end
        local inv = user:get_inventory()
        if not inv:contains_item("main", "items:pointed_arrow") then
            return itemstack  -- no ammunition
        end
        -- Consume one arrow
        inv:remove_item("main", ItemStack("items:pointed_arrow 1"))
        -- Spawn projectile in look direction
        local pos = user:get_pos()
        if not pos then return itemstack end
        pos.y = pos.y + 1.5
        local dir = user:get_look_dir()
        local speed = 20
        local vel = vector.multiply(dir, speed)
        local obj = minetest.add_entity(pos, "entities:pointed_arrow")
        if obj then
            obj:set_velocity(vel)
            local ent = obj:get_luaentity()
            if ent then
                ent.owner = user:get_player_name()
                ent.damage = 6
            end
            -- Face the direction of travel
            obj:set_yaw(user:get_look_horizontal())
            obj:set_pitch(user:get_look_vertical())
        end
        -- Apply wear (durability)
        itemstack:add_wear(800)
        core.log("action", "[items] Timberbow fired by " .. user:get_player_name())
        return itemstack
    end,
})

core.log("action", "[items] Basic tools, early armor/accessories, and timberbow registered")
