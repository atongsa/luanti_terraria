-- Core mod for Luanti Terraria-inspired game
-- Day 4: Player physics tuning (speed, jump, gravity, fall damage)
-- Day 7: Day/night cycle + basic time-of-day lighting

core.log("action", "[core] Luanti Terraria-inspired game core mod loaded")

-- Physics overrides for Terraria-like platforming feel in 3D
-- Higher jump, slightly faster movement, lower gravity for floatier jumps
local PHYSICS = {
    speed = 1.2,      -- movement speed multiplier
    jump = 1.8,       -- jump height multiplier
    gravity = 0.7,    -- lower gravity for floatier feel
    sneak = 1.0,
    sneak_glitch = false,
    new_move = true,  -- use improved movement if available
}

-- Custom fall damage: safe fall height ~8 blocks, then scaling damage
-- Cancels engine fall damage and applies our own
local SAFE_FALL = 8
local DAMAGE_PER_BLOCK = 2

local last_y = {}
local is_falling = {}

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    player:set_physics_override(PHYSICS)
    last_y[name] = player:get_pos().y
    is_falling[name] = false
    core.log("action", "[core] Applied physics overrides to " .. name)

    -- Day 7: Basic sky for time-of-day lighting (engine handles sunlight fade)
    player:set_sky({
        base_color = {r=135, g=206, b=235},
        type = "regular",
        clouds = true,
    })
    player:set_sun({
        visible = true,
        sunrise_visible = true,
    })
    player:set_moon({
        visible = true,
    })
    player:set_stars({
        visible = true,
        count = 1000,
    })
end)

minetest.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    last_y[name] = nil
    is_falling[name] = nil
end)

-- Cancel default engine fall damage so we control it
minetest.register_on_player_hpchange(function(player, hp_change, reason)
    if reason and reason.type == "fall" then
        return 0  -- cancel
    end
    return hp_change
end, true)

-- Track falls and apply custom damage on landing
minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local name = player:get_player_name()
        if not last_y[name] then
            last_y[name] = player:get_pos().y
            is_falling[name] = false
        end

        local pos = player:get_pos()
        local vel = player:get_velocity()
        local y = pos.y

        if vel and vel.y < -1.0 then
            is_falling[name] = true
        elseif is_falling[name] and vel and math.abs(vel.y) < 0.5 then
            -- Landed
            local fall_dist = last_y[name] - y
            if fall_dist > SAFE_FALL then
                local damage = math.floor((fall_dist - SAFE_FALL) * DAMAGE_PER_BLOCK)
                if damage > 0 then
                    local hp = player:get_hp()
                    player:set_hp(math.max(0, hp - damage))
                    core.log("action", "[core] Fall damage " .. damage .. " to " .. name .. " (fell " .. math.floor(fall_dist) .. " blocks)")
                end
            end
            is_falling[name] = false
        end

        last_y[name] = y
    end
end)

-- Day 7: Ensure day/night cycle is active with reasonable speed
-- time_speed 72 ≈ full day cycle in about 20 minutes real time (engine default-ish)
-- 0 = midnight, 0.25 = sunrise, 0.5 = noon, 0.75 = sunset
minetest.settings:set("time_speed", "72")

-- Start new worlds near sunrise for visibility
minetest.register_on_newplayer(function(player)
    minetest.set_timeofday(0.25)
    core.log("action", "[core] Set initial timeofday to sunrise for new player")
end)

-- Also set on first join if time is still default midnight
minetest.register_on_joinplayer(function(player)
    local tod = minetest.get_timeofday()
    if tod < 0.01 or tod > 0.99 then
        minetest.set_timeofday(0.25)
    end
end)

-- Simple chat command for testing the cycle
minetest.register_chatcommand("time", {
    params = "[0.0-1.0]",
    description = "Get or set time of day (0=midnight, 0.5=noon)",
    func = function(name, param)
        if param == "" then
            local tod = minetest.get_timeofday()
            return true, string.format("Current time of day: %.3f", tod)
        end
        local t = tonumber(param)
        if t and t >= 0 and t <= 1 then
            minetest.set_timeofday(t)
            return true, string.format("Time of day set to %.3f", t)
        end
        return false, "Usage: /time [0.0 to 1.0]"
    end,
})

core.log("action", "[core] Player physics tuning registered (Terraria-like 3D feel)")
core.log("action", "[core] Day/night cycle enabled with time_speed=72 and basic sky lighting")
