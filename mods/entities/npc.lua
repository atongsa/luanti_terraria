-- Day 13: Basic NPC (Wayseer - Guide equivalent)
-- Original name/design: tall standing figure that offers tips via dialog formspec.
-- Does not attack; right-click to talk. Spawns via command or naturally near surface on first join.

local WAYSEER_TIPS = {
    "Welcome, traveler. The world is vast and layered. Dig carefully.",
    "Gelblobs hop toward you and damage on contact. Punch them with a shortblade.",
    "Craft a Craftbench from timber to unlock better recipes.",
    "Hide armor reduces damage. Equip it with /equip after crafting from gel residue.",
    "The Timberbow fires pointed arrows. Aim carefully and keep ammunition stocked.",
    "At night, a Gloomseer may appear if you are wounded. Use a Gloom Lens to summon it deliberately.",
    "Explore different surface biomes: forests, deserts, and snowy lands.",
    "Deeper underground holds rarer ores. Bring a strong pickaxe.",
}

minetest.register_entity("entities:wayseer", {
    initial_properties = {
        physical = true,
        collide_with_objects = true,
        collisionbox = {-0.3, 0, -0.3, 0.3, 1.7, 0.3},
        visual = "cube",
        textures = {"nodes_timber.png"},  -- placeholder brown for the figure
        visual_size = {x = 0.8, y = 1.8, z = 0.8},
        makes_footstep_sound = true,
        automatic_rotate = 0,
    },
    idle_timer = 0,

    on_activate = function(self, staticdata)
        self.object:set_armor_groups({fleshy = 100})
        self.idle_timer = math.random() * 3
        -- Slight hover so it stands on ground
        self.object:set_acceleration({x = 0, y = -9.8, z = 0})
        core.log("action", "[entities] Wayseer activated")
    end,

    on_step = function(self, dtime)
        self.idle_timer = self.idle_timer + dtime
        local pos = self.object:get_pos()
        if not pos then return end

        -- Light gravity to stay grounded
        self.object:set_acceleration({x = 0, y = -9.8, z = 0})

        -- Idle slight bob or random look (simple velocity zero most of the time)
        if self.idle_timer > 4 then
            local vel = {
                x = (math.random() - 0.5) * 0.4,
                y = 0,
                z = (math.random() - 0.5) * 0.4,
            }
            self.object:set_velocity(vel)
            self.idle_timer = 0
        else
            -- Dampen horizontal velocity
            local vel = self.object:get_velocity()
            if vel then
                self.object:set_velocity({x = vel.x * 0.9, y = vel.y, z = vel.z * 0.9})
            end
        end
    end,

    on_rightclick = function(self, clicker)
        if not clicker or not clicker:is_player() then return end
        local name = clicker:get_player_name()
        local tip = WAYSEER_TIPS[math.random(#WAYSEER_TIPS)]
        local formspec = "size[8,6]" ..
            "label[0.5,0.5;Wayseer]" ..
            "textarea[0.5,1.2;7,3.5;;" .. minetest.formspec_escape(tip) .. ";]" ..
            "button_exit[3,5;2,0.8;close;Close]"
        minetest.show_formspec(name, "entities:wayseer_dialog", formspec)
        core.log("action", "[entities] Wayseer dialog opened for " .. name)
    end,

    on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
        -- Friendly: do not die or take meaningful damage from players
        if puncher and puncher:is_player() then
            minetest.chat_send_player(puncher:get_player_name(), "The Wayseer is friendly and does not fight.")
        end
    end,
})

-- Testing / spawn command
minetest.register_chatcommand("spawnwayseer", {
    description = "Spawn the Wayseer NPC near you",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then return false, "Player not found" end
        local pos = player:get_pos()
        pos.y = pos.y + 1
        pos.x = pos.x + 2
        minetest.add_entity(pos, "entities:wayseer")
        return true, "Spawned Wayseer"
    end,
})

-- Natural spawn: once per world near the first player who joins (simple Guide-like arrival)
local wayseer_spawned = false
minetest.register_on_joinplayer(function(player)
    if wayseer_spawned then return end
    minetest.after(3, function()
        if wayseer_spawned then return end
        local pos = player:get_pos()
        if pos then
            local spawn_pos = {
                x = pos.x + math.random(-8, 8),
                y = pos.y + 2,
                z = pos.z + math.random(-8, 8),
            }
            -- Try to find a solid ground nearby (simple)
            local ground = minetest.find_node_near(spawn_pos, 8, {"nodes:turf", "nodes:soil", "nodes:cragstone", "nodes:sand"})
            if ground then
                ground.y = ground.y + 1
                minetest.add_entity(ground, "entities:wayseer")
                minetest.chat_send_all("A Wayseer has arrived to offer guidance.")
                core.log("action", "[entities] Natural Wayseer spawn")
                wayseer_spawned = true
            end
        end
    end)
end)

core.log("action", "[entities] Wayseer NPC registered")
