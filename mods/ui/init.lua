-- UI mod
-- Day 10: Inventory & equipment slots (armor + accessories)
-- Original early hide armor set + gel charm accessory
-- Equipment formspec, slot validation, and damage reduction

core.log("action", "[ui] UI mod loaded")

local SLOT_LISTS = {
    head = "equip_head",
    chest = "equip_chest",
    legs = "equip_legs",
    feet = "equip_feet",
    accessory = "equip_acc1",  -- first accessory; second handled separately
}

local ALL_EQUIP_LISTS = {
    "equip_head", "equip_chest", "equip_legs", "equip_feet",
    "equip_acc1", "equip_acc2",
}

-- Setup equipment inventory lists on join
minetest.register_on_joinplayer(function(player)
    local inv = player:get_inventory()
    for _, listname in ipairs(ALL_EQUIP_LISTS) do
        if inv:get_size(listname) == 0 then
            inv:set_size(listname, 1)
        end
    end
    core.log("action", "[ui] Equipment slots ready for " .. player:get_player_name())
end)

-- Calculate total defense from equipped items
local function get_player_defense(player)
    local inv = player:get_inventory()
    local total = 0
    for _, listname in ipairs(ALL_EQUIP_LISTS) do
        local stack = inv:get_stack(listname, 1)
        if not stack:is_empty() then
            local def = minetest.get_item_group(stack:get_name(), "defense")
            if def > 0 then
                total = total + def
            end
        end
    end
    return total
end

-- Damage reduction: subtract defense (flat, min 1 remaining damage if original > 0)
-- Applies to all negative HP changes (gelblob contact, fall, etc.)
minetest.register_on_player_hpchange(function(player, hp_change, reason)
    if hp_change >= 0 then return hp_change end
    local defense = get_player_defense(player)
    if defense <= 0 then return hp_change end
    local reduced = hp_change + defense  -- hp_change is negative
    if reduced > -1 and hp_change < 0 then
        reduced = -1  -- always at least 1 damage if hit was damaging
    end
    if reduced ~= hp_change then
        core.log("action", "[ui] Damage reduced by " .. defense .. " defense for " .. player:get_player_name() .. " (" .. hp_change .. " -> " .. reduced .. ")")
    end
    return reduced
end, true)

-- Equipment formspec
local function get_equip_formspec(player)
    local name = player:get_player_name()
    return "size[10,9]" ..
        "label[0.5,0;Equipment]" ..
        "label[0.5,0.5;Head]" ..
        "list[current_player;equip_head;0.5,1;1,1;]" ..
        "label[2,0.5;Chest]" ..
        "list[current_player;equip_chest;2,1;1,1;]" ..
        "label[3.5,0.5;Legs]" ..
        "list[current_player;equip_legs;3.5,1;1,1;]" ..
        "label[5,0.5;Feet]" ..
        "list[current_player;equip_feet;5,1;1,1;]" ..
        "label[7,0.5;Accessories]" ..
        "list[current_player;equip_acc1;7,1;1,1;]" ..
        "list[current_player;equip_acc2;8.2,1;1,1;]" ..
        "label[0.5,2.5;Defense: " .. get_player_defense(player) .. "]" ..
        "list[current_player;main;0,4;8,4;]" ..
        "listring[current_player;main]" ..
        "listring[current_player;equip_head]" ..
        "listring[current_player;equip_chest]" ..
        "listring[current_player;equip_legs]" ..
        "listring[current_player;equip_feet]" ..
        "listring[current_player;equip_acc1]" ..
        "listring[current_player;equip_acc2]"
end

-- Chat command to open equipment
minetest.register_chatcommand("equip", {
    description = "Open equipment / armor slots",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then return false, "Player not found" end
        minetest.show_formspec(name, "ui:equipment", get_equip_formspec(player))
        return true, "Equipment opened"
    end,
})

-- Allow only matching armor into slots
local function can_equip_to_slot(stack, listname)
    if stack:is_empty() then return 1 end
    local itemname = stack:get_name()
    local slot_group = minetest.get_item_group(itemname, "armor_slot")
    if slot_group == 0 then return 0 end

    if listname == "equip_head" and slot_group == "head" then return 1 end
    if listname == "equip_chest" and slot_group == "chest" then return 1 end
    if listname == "equip_legs" and slot_group == "legs" then return 1 end
    if listname == "equip_feet" and slot_group == "feet" then return 1 end
    if (listname == "equip_acc1" or listname == "equip_acc2") and slot_group == "accessory" then return 1 end
    return 0
end

minetest.register_allow_player_inventory_action(function(player, action, inventory, info)
    if action == "put" or action == "take" or action == "move" then
        local listname = info.listname or (info.to_list or info.from_list)
        if listname and listname:sub(1, 6) == "equip_" then
            local stack = info.stack or inventory:get_stack(info.from_list or listname, info.from_index or 1)
            if action == "put" then
                stack = info.stack
            elseif action == "move" and info.to_list and info.to_list:sub(1, 6) == "equip_" then
                stack = inventory:get_stack(info.from_list, info.from_index)
                listname = info.to_list
            end
            if not can_equip_to_slot(stack, listname) then
                return 0
            end
        end
    end
    return nil  -- allow default
end)

core.log("action", "[ui] Equipment system registered (armor slots + accessories + damage reduction)")
