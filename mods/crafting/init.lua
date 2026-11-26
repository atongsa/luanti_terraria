-- Crafting mod
-- Day 6: Simple crafting system + workbench (craftbench)
-- Day 10: Recipes for early hide armor and gel charm
-- Day 11: Recipes for timberbow and pointed arrows
-- Original names and designs only

core.log("action", "[crafting] Crafting mod loaded")

local function get_craft_result_list(inv)
    local list = inv:get_list("craft") or {}
    -- Ensure 9 slots
    for i = 1, 9 do
        if not list[i] then list[i] = ItemStack() end
    end
    return minetest.get_craft_result({method = "normal", width = 3, items = list})
end

local function update_preview(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local result = get_craft_result_list(inv)
    if result.item and not result.item:is_empty() then
        inv:set_stack("craftpreview", 1, result.item)
    else
        inv:set_stack("craftpreview", 1, ItemStack())
    end
end

local function consume_inputs(inv)
    local result = get_craft_result_list(inv)
    if result.replacements then
        for i, stack in ipairs(result.replacements) do
            inv:set_stack("craft", i, stack)
        end
    else
        -- Fallback: take 1 from each non-empty slot
        for i = 1, 9 do
            local stack = inv:get_stack("craft", i)
            if not stack:is_empty() then
                stack:take_item(1)
                inv:set_stack("craft", i, stack)
            end
        end
    end
end

minetest.register_node("crafting:craftbench", {
    description = "Craftbench",
    tiles = {"nodes_timber.png"},
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
    is_ground_content = false,
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
            "size[8,9]" ..
            "label[0.5,0;Craftbench]" ..
            "list[context;craft;1.75,0.5;3,3;]" ..
            "list[context;craftpreview;5.75,1.5;1,1;]" ..
            "list[current_player;main;0,5;8,4;]" ..
            "listring[context;craft]" ..
            "listring[current_player;main]"
        )
        local inv = meta:get_inventory()
        inv:set_size("craft", 9)
        inv:set_size("craftpreview", 1)
    end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        if from_list == "craft" or to_list == "craft" then
            update_preview(pos)
        end
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        if listname == "craft" then
            update_preview(pos)
        end
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
        if listname == "craftpreview" then
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            -- Only consume if there was a valid result
            local check = get_craft_result_list(inv)
            if check.item and not check.item:is_empty() then
                consume_inputs(inv)
            end
            update_preview(pos)
        elseif listname == "craft" then
            update_preview(pos)
        end
    end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
        if listname == "craftpreview" then
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local result = get_craft_result_list(inv)
            if result.item and not result.item:is_empty() and result.item:get_name() == stack:get_name() then
                return stack:get_count()
            end
            return 0
        end
        return stack:get_count()
    end,
})

core.log("action", "[crafting] Registered craftbench node")

-- Recipes (shaped, original)
-- Craftbench itself (2x2, can be made in player inventory)
minetest.register_craft({
    output = "crafting:craftbench",
    recipe = {
        {"nodes:timber", "nodes:timber"},
        {"nodes:timber", "nodes:timber"},
    }
})

-- Tools require the 3x3 craftbench
minetest.register_craft({
    output = "items:cragpick",
    recipe = {
        {"nodes:cragstone", "nodes:cragstone", "nodes:cragstone"},
        {"", "nodes:timber", ""},
        {"", "nodes:timber", ""},
    }
})

minetest.register_craft({
    output = "items:timberaxe",
    recipe = {
        {"nodes:timber", "nodes:timber"},
        {"nodes:timber", "nodes:timber"},
        {"", "nodes:timber", ""},
    }
})

minetest.register_craft({
    output = "items:soilscoop",
    recipe = {
        {"nodes:soil", "nodes:soil"},
        {"", "nodes:timber", ""},
        {"", "nodes:timber", ""},
    }
})

minetest.register_craft({
    output = "items:shortblade",
    recipe = {
        {"nodes:cragstone"},
        {"nodes:cragstone"},
        {"nodes:timber"},
    }
})

-- Day 10: Early hide armor (gel residue + timber)
minetest.register_craft({
    output = "items:hide_cap",
    recipe = {
        {"entities:gel_residue", "entities:gel_residue", "entities:gel_residue"},
        {"entities:gel_residue", "", "entities:gel_residue"},
    }
})

minetest.register_craft({
    output = "items:hide_tunic",
    recipe = {
        {"entities:gel_residue", "", "entities:gel_residue"},
        {"entities:gel_residue", "entities:gel_residue", "entities:gel_residue"},
        {"entities:gel_residue", "entities:gel_residue", "entities:gel_residue"},
    }
})

minetest.register_craft({
    output = "items:hide_leggings",
    recipe = {
        {"entities:gel_residue", "entities:gel_residue", "entities:gel_residue"},
        {"entities:gel_residue", "", "entities:gel_residue"},
        {"entities:gel_residue", "", "entities:gel_residue"},
    }
})

minetest.register_craft({
    output = "items:hide_boots",
    recipe = {
        {"entities:gel_residue", "", "entities:gel_residue"},
        {"entities:gel_residue", "", "entities:gel_residue"},
    }
})

minetest.register_craft({
    output = "items:gel_charm",
    recipe = {
        {"entities:gel_residue", "nodes:timber"},
        {"nodes:timber", "entities:gel_residue"},
    }
})

-- Day 11: Timberbow and pointed arrows
minetest.register_craft({
    output = "items:timberbow",
    recipe = {
        {"nodes:timber", "", "nodes:timber"},
        {"nodes:timber", "nodes:timber", "nodes:timber"},
        {"", "nodes:timber", ""},
    }
})

minetest.register_craft({
    output = "items:pointed_arrow 8",
    recipe = {
        {"nodes:cragstone"},
        {"nodes:timber"},
        {"nodes:timber"},
    }
})

core.log("action", "[crafting] Basic recipes registered for craftbench, tools, early armor, and ranged gear")
