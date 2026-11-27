-- Day 12: First boss - Gloomseer
-- Original name/design: large floating eye-like entity that dashes and spawns servants at night.
-- Mechanics inspired by classic eye boss (phases, dashes, minions) but fully original names and design.

local GLOOMSEER_HP = 180
local PHASE2_HP = 90
local BOSS_CONTACT_RANGE = 2.2
local BOSS_DAMAGE_P1 = 6
local BOSS_DAMAGE_P2 = 10
local BOSS_AGGRO = 40

minetest.register_entity("entities:gloomseer", {
    initial_properties = {
        physical = true,
        collide_with_objects = true,
        collisionbox = {-1.1, -1.1, -1.1, 1.1, 1.1, 1.1},
        visual = "cube",
        textures = {"nodes_cragstone.png"},  -- placeholder gray stone for the "eye" body
        visual_size = {x = 2.2, y = 2.2, z = 2.2},
        automatic_rotate = math.pi / 3,
        makes_footstep_sound = false,
    },
    hp = GLOOMSEER_HP,
    phase = 1,
    timer = 0,
    dash_timer = 0,
    minion_timer = 0,
    damage_timer = 0,
    dashing = false,

    on_activate = function(self, staticdata)
        self.object:set_armor_groups({fleshy = 100})
        self.hp = GLOOMSEER_HP
        self.phase = 1
        self.timer = 0
        self.dash_timer = 2
        self.minion_timer = 5
        self.damage_timer = 0
        self.dashing = false
        self.object:set_acceleration({x = 0, y = 0, z = 0})
        core.log("action", "[entities] Gloomseer activated (phase 1)")
    end,

    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        self.dash_timer = self.dash_timer + dtime
        self.minion_timer = self.minion_timer + dtime
        self.damage_timer = math.max(0, self.damage_timer - dtime)

        local pos = self.object:get_pos()
        if not pos then return end

        -- Hover / cancel gravity
        self.object:set_acceleration({x = 0, y = 0, z = 0})

        -- Find nearest player
        local nearest = nil
        local min_dist = BOSS_AGGRO
        local nearest_pos = nil
        for _, player in ipairs(minetest.get_connected_players()) do
            local ppos = player:get_pos()
            if ppos then
                local dist = vector.distance(pos, ppos)
                if dist < min_dist then
                    min_dist = dist
                    nearest = player
                    nearest_pos = ppos
                end
            end
        end

        if nearest and nearest_pos then
            local dir = vector.direction(pos, nearest_pos)
            local speed = (self.phase == 1) and 4 or 7
            local dash_interval = (self.phase == 1) and 4.5 or 2.2

            -- Dash periodically toward player
            if self.dash_timer > dash_interval then
                local dash_speed = speed * 3.5
                self.object:set_velocity({
                    x = dir.x * dash_speed,
                    y = dir.y * dash_speed * 0.6,
                    z = dir.z * dash_speed,
                })
                self.dashing = true
                self.dash_timer = 0
                core.log("action", "[entities] Gloomseer dashing (phase " .. self.phase .. ")")
            elseif self.dashing and self.dash_timer > 0.8 then
                -- End dash, slow approach
                self.dashing = false
                self.object:set_velocity({
                    x = dir.x * speed,
                    y = dir.y * speed * 0.4,
                    z = dir.z * speed,
                })
            elseif not self.dashing then
                -- Slow hover toward player
                self.object:set_velocity({
                    x = dir.x * speed * 0.6,
                    y = dir.y * speed * 0.3,
                    z = dir.z * speed * 0.6,
                })
            end

            -- Contact damage
            local dmg = (self.phase == 1) and BOSS_DAMAGE_P1 or BOSS_DAMAGE_P2
            if min_dist < BOSS_CONTACT_RANGE and self.damage_timer <= 0 then
                local hp = nearest:get_hp()
                nearest:set_hp(math.max(0, hp - dmg))
                local knock = vector.direction(pos, nearest_pos)
                nearest:add_velocity({x = knock.x * 8, y = 4, z = knock.z * 8})
                self.damage_timer = 1.0
                core.log("action", "[entities] Gloomseer damaged player for " .. dmg)
            end

            -- Spawn minion gelblobs occasionally
            if self.minion_timer > 8 then
                local spawn_pos = {
                    x = pos.x + (math.random() - 0.5) * 6,
                    y = pos.y + 1,
                    z = pos.z + (math.random() - 0.5) * 6,
                }
                minetest.add_entity(spawn_pos, "entities:gelblob")
                self.minion_timer = 0
                core.log("action", "[entities] Gloomseer spawned a gelblob servant")
            end
        else
            -- Idle hover
            if self.timer > 3 then
                self.object:set_velocity({
                    x = (math.random() - 0.5) * 2,
                    y = (math.random() - 0.5) * 1,
                    z = (math.random() - 0.5) * 2,
                })
                self.timer = 0
            end
        end
    end,

    on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
        if not puncher or not puncher:is_player() then return end
        if time_from_last_punch < 0.35 then return end

        local damage = 3
        if tool_capabilities and tool_capabilities.damage_groups and tool_capabilities.damage_groups.fleshy then
            damage = tool_capabilities.damage_groups.fleshy
        end

        self.hp = self.hp - damage
        core.log("action", "[entities] Gloomseer punched for " .. damage .. ", HP: " .. self.hp)

        if dir then
            local current = self.object:get_velocity() or {x=0,y=0,z=0}
            self.object:set_velocity({
                x = current.x + dir.x * 4,
                y = current.y + 2,
                z = current.z + dir.z * 4,
            })
        end

        -- Phase transition
        if self.phase == 1 and self.hp <= PHASE2_HP then
            self.phase = 2
            -- Visual change: slightly larger / different texture feel
            self.object:set_properties({
                visual_size = {x = 2.5, y = 2.5, z = 2.5},
                textures = {"nodes_turf.png"},  -- switch to green for phase 2 "enraged" look
            })
            core.log("action", "[entities] Gloomseer entered phase 2!")
            minetest.chat_send_all("The Gloomseer becomes more aggressive!")
        end

        if self.hp <= 0 then
            local drop_pos = self.object:get_pos()
            if drop_pos then
                minetest.add_item(drop_pos, "entities:gel_residue 4")
                minetest.add_item(drop_pos, "entities:gloom_shard")
            end
            self.object:remove()
            minetest.chat_send_all("The Gloomseer has been defeated!")
            core.log("action", "[entities] Gloomseer defeated")
        end
    end,
})

-- Unique drop from the boss
minetest.register_craftitem("entities:gloom_shard", {
    description = "Gloom Shard",
    inventory_image = "nodes_cragstone.png",  -- placeholder
    groups = {boss_drop = 1},
})

-- Testing / summon command (also usable anytime for debug)
minetest.register_chatcommand("spawngloomseer", {
    description = "Spawn the Gloomseer boss near you (for testing)",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then return false, "Player not found" end
        local pos = player:get_pos()
        pos.y = pos.y + 8
        pos.x = pos.x + 6
        minetest.add_entity(pos, "entities:gloomseer")
        minetest.chat_send_all("A Gloomseer has appeared!")
        return true, "Spawned Gloomseer"
    end,
})

-- Night-time natural spawn check (simple: once per night chance if players present and somewhat hurt)
local night_spawn_checked = false
minetest.register_globalstep(function(dtime)
    local tod = minetest.get_timeofday()
    local is_night = (tod < 0.25 or tod > 0.75)
    if is_night and not night_spawn_checked then
        -- Chance to spawn near a random player if no boss already (simple check)
        if math.random() < 0.15 then  -- low chance per night transition
            local players = minetest.get_connected_players()
            if #players > 0 then
                local p = players[math.random(#players)]
                local ppos = p:get_pos()
                if ppos and p:get_hp() < 16 then  -- only if somewhat hurt (classic condition feel)
                    local spawn_pos = {x = ppos.x + 12, y = ppos.y + 10, z = ppos.z + 12}
                    minetest.add_entity(spawn_pos, "entities:gloomseer")
                    minetest.chat_send_all("You feel a watching presence... The Gloomseer has arrived!")
                    core.log("action", "[entities] Natural Gloomseer night spawn")
                end
            end
        end
        night_spawn_checked = true
    elseif not is_night then
        night_spawn_checked = false
    end
end)

core.log("action", "[entities] Gloomseer boss registered")
