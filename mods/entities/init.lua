-- Entities mod
-- Day 8: First enemy (gelblob - slime-like) + basic melee combat (melee hit detection)
-- Original name and design: green hopping blob that approaches players and damages on contact

core.log("action", "[entities] Entities mod loaded")

-- Simple residue drop item (original)
minetest.register_craftitem("entities:gel_residue", {
    description = "Gel Residue",
    inventory_image = "nodes_turf.png",  -- placeholder solid green
    groups = {gel = 1},
})

local GELBLOB_HP = 12
local GELBLOB_DAMAGE = 2
local GELBLOB_HOP_SPEED = 2.5
local CONTACT_RANGE = 1.3
local AGGRO_RANGE = 14
local DAMAGE_COOLDOWN = 1.2

minetest.register_entity("entities:gelblob", {
    initial_properties = {
        physical = true,
        collide_with_objects = true,
        collisionbox = {-0.35, -0.35, -0.35, 0.35, 0.35, 0.35},
        visual = "cube",
        textures = {"nodes_turf.png"},  -- placeholder green (turf texture)
        visual_size = {x = 0.7, y = 0.7, z = 0.7},
        makes_footstep_sound = false,
        automatic_rotate = math.pi / 2,
    },
    hp = GELBLOB_HP,
    timer = 0,
    damage_timer = 0,

    on_activate = function(self, staticdata)
        self.object:set_armor_groups({fleshy = 100})
        self.hp = GELBLOB_HP
        self.timer = math.random() * 2
        self.damage_timer = 0
        -- Give a small initial upward nudge so it starts hopping
        self.object:set_velocity({x = 0, y = 2, z = 0})
    end,

    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        self.damage_timer = math.max(0, self.damage_timer - dtime)

        local pos = self.object:get_pos()
        if not pos then return end

        -- Apply light gravity so hops feel bouncy
        local vel = self.object:get_velocity()
        if vel then
            self.object:set_acceleration({x = 0, y = -8, z = 0})
        end

        -- Find nearest player
        local nearest = nil
        local min_dist = AGGRO_RANGE
        for _, player in ipairs(minetest.get_connected_players()) do
            local ppos = player:get_pos()
            if ppos then
                local dist = vector.distance(pos, ppos)
                if dist < min_dist then
                    min_dist = dist
                    nearest = player
                end
            end
        end

        if nearest then
            -- Hop toward the player periodically
            if self.timer > 1.4 then
                local dir = vector.direction(pos, nearest:get_pos())
                local hop_vel = {
                    x = dir.x * GELBLOB_HOP_SPEED,
                    y = 4.5,
                    z = dir.z * GELBLOB_HOP_SPEED,
                }
                self.object:set_velocity(hop_vel)
                self.timer = 0
            end

            -- Contact damage (melee-style on collision)
            if min_dist < CONTACT_RANGE and self.damage_timer <= 0 then
                local hp = nearest:get_hp()
                nearest:set_hp(math.max(0, hp - GELBLOB_DAMAGE))
                -- Small knockback
                local knock = vector.direction(pos, nearest:get_pos())
                nearest:add_velocity({x = knock.x * 4, y = 2, z = knock.z * 4})
                self.damage_timer = DAMAGE_COOLDOWN
                core.log("action", "[entities] Gelblob damaged player for " .. GELBLOB_DAMAGE)
            end
        else
            -- Idle random hop
            if self.timer > 2.8 then
                local hop_vel = {
                    x = (math.random() - 0.5) * 2,
                    y = 3.5,
                    z = (math.random() - 0.5) * 2,
                }
                self.object:set_velocity(hop_vel)
                self.timer = 0
            end
        end
    end,

    on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
        if not puncher or not puncher:is_player() then return end
        if time_from_last_punch < 0.4 then return end  -- basic attack cooldown

        local damage = 2
        if tool_capabilities and tool_capabilities.damage_groups and tool_capabilities.damage_groups.fleshy then
            damage = tool_capabilities.damage_groups.fleshy
        end

        self.hp = self.hp - damage
        core.log("action", "[entities] Gelblob punched for " .. damage .. " damage, HP remaining: " .. self.hp)

        -- Knockback from punch direction
        if dir then
            local current = self.object:get_velocity() or {x=0,y=0,z=0}
            self.object:set_velocity({
                x = current.x + dir.x * 6,
                y = current.y + 3,
                z = current.z + dir.z * 6,
            })
        end

        if self.hp <= 0 then
            local drop_pos = self.object:get_pos()
            if drop_pos then
                minetest.add_item(drop_pos, "entities:gel_residue")
            end
            self.object:remove()
            core.log("action", "[entities] Gelblob defeated")
        end
    end,
})

-- Testing command to spawn a gelblob
minetest.register_chatcommand("spawnblob", {
    description = "Spawn a gelblob (slime-like enemy) near you",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then return false, "Player not found" end
        local pos = player:get_pos()
        pos.y = pos.y + 1.5
        minetest.add_entity(pos, "entities:gelblob")
        return true, "Spawned gelblob"
    end,
})

core.log("action", "[entities] Gelblob enemy and basic melee combat registered")
