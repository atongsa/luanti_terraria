-- Mapgen mod
-- Day 3: Custom mapgen - surface + underground + basic caves (Terraria-style vertical layers)
-- Day 9: Expanded with surface biomes (forest, desert, snow) + early-tier ore distribution
-- Original implementation: biome selection via large-scale noise, trees in forest, depth-based ores

core.log("action", "[mapgen] Custom mapgen mod loaded")

-- Force singlenode mapgen so we fully control generation
minetest.set_mapgen_setting("mg_name", "singlenode", true)
minetest.set_mapgen_setting("water_level", "-31000", true) -- effectively no water for now

local c_air = minetest.get_content_id("air")
local c_soil = minetest.get_content_id("nodes:soil")
local c_turf = minetest.get_content_id("nodes:turf")
local c_stone = minetest.get_content_id("nodes:cragstone")
local c_sand = minetest.get_content_id("nodes:sand")
local c_snow = minetest.get_content_id("nodes:snow")
local c_timber = minetest.get_content_id("nodes:timber")
local c_foliage = minetest.get_content_id("nodes:foliage")
local c_copral = minetest.get_content_id("nodes:copral_ore")
local c_ferrite = minetest.get_content_id("nodes:ferrite_ore")
local c_argentite = minetest.get_content_id("nodes:argentite_ore")
local c_aurite = minetest.get_content_id("nodes:aurite_ore")

-- Base surface height (Y level)
local BASE_SURFACE = 8
local DIRT_DEPTH = 4

-- Simple large-scale biome noise (original, no external libs)
local function get_biome(x, z)
	local nx = math.sin(x * 0.008) + math.cos(z * 0.007) * 0.8
	local nz = math.cos(x * 0.006) + math.sin(z * 0.009)
	local val = (nx + nz) * 0.5
	if val > 0.35 then
		return "desert"
	elseif val < -0.35 then
		return "snow"
	else
		return "forest"
	end
end

minetest.register_on_generated(function(minp, maxp, seed)
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()
	local pr = PseudoRandom(seed + minp.x + minp.z * 100)

	-- Generate layered terrain with biomes
	for z = minp.z, maxp.z do
		for x = minp.x, maxp.x do
			local biome = get_biome(x, z)
			-- Simple height variation for natural surface (original math)
			local height_var = math.floor(math.sin(x * 0.15) * 3 + math.cos(z * 0.12) * 2.5)
			if biome == "desert" then
				height_var = height_var + math.floor(math.sin(x * 0.05) * 2) -- slightly higher dunes
			end
			local surface = BASE_SURFACE + height_var

			local surface_node = c_turf
			local under_node = c_soil
			if biome == "desert" then
				surface_node = c_sand
				under_node = c_sand -- thin sand layer
			elseif biome == "snow" then
				surface_node = c_snow
			end

			for y = minp.y, maxp.y do
				local vi = area:index(x, y, z)
				if y > surface then
					data[vi] = c_air
				elseif y == surface then
					data[vi] = surface_node
				elseif y > surface - DIRT_DEPTH then
					data[vi] = under_node
				else
					-- Underground stone with ore placement (early Terraria-tier feel: copper shallow, gold deeper)
					local ore_roll = pr:next(1, 200)
					if y > -10 and ore_roll <= 3 then
						data[vi] = c_copral -- shallow copper-like
					elseif y > -40 and y <= -5 and ore_roll <= 2 then
						data[vi] = c_ferrite -- mid iron-like
					elseif y > -80 and y <= -30 and ore_roll <= 1 then
						data[vi] = c_argentite -- deeper silver-like
					elseif y <= -60 and ore_roll <= 1 then
						data[vi] = c_aurite -- deepest early gold-like
					else
						data[vi] = c_stone
					end
				end
			end

			-- Simple trees in forest biome (original placement)
			if biome == "forest" and pr:next(1, 25) == 1 then
				local trunk_h = pr:next(3, 5)
				for ty = 1, trunk_h do
					local tyy = surface + ty
					if tyy >= minp.y and tyy <= maxp.y then
						local tvi = area:index(x, tyy, z)
						data[tvi] = c_timber
					end
				end
				-- Simple foliage canopy
				for fy = 0, 2 do
					for fx = -1, 1 do
						for fz = -1, 1 do
							if not (fx == 0 and fz == 0 and fy < 2) then
								local fyy = surface + trunk_h + fy
								local fxx, fzz = x + fx, z + fz
								if fxx >= minp.x and fxx <= maxp.x and fyy >= minp.y and fyy <= maxp.y and fzz >= minp.z and fzz <= maxp.z then
									local fvi = area:index(fxx, fyy, fzz)
									if data[fvi] == c_air then
										data[fvi] = c_foliage
									end
								end
							end
						end
					end
				end
			end
		end
	end

	-- Basic caves: carve small random voids in the underground stone layer
	-- (Terraria-style underground exploration feel, original simple implementation)
	local cave_attempts = 15
	for i = 1, cave_attempts do
		local cx = pr:next(minp.x, maxp.x)
		local cz = pr:next(minp.z, maxp.z)
		local cy = pr:next(math.max(minp.y, -20), BASE_SURFACE - DIRT_DEPTH - 2)

		if cy < BASE_SURFACE - DIRT_DEPTH then
			local radius = pr:next(2, 4)
			for dy = -radius, radius do
				for dx = -radius, radius do
					for dz = -radius, radius do
						if dx*dx + dy*dy + dz*dz <= radius * radius then
							local nx, ny, nz = cx + dx, cy + dy, cz + dz
							if nx >= minp.x and nx <= maxp.x and ny >= minp.y and ny <= maxp.y and nz >= minp.z and nz <= maxp.z then
								local vi = area:index(nx, ny, nz)
								if data[vi] == c_stone or data[vi] == c_copral or data[vi] == c_ferrite or data[vi] == c_argentite or data[vi] == c_aurite then
									data[vi] = c_air
								end
							end
					end
				end
			end
		end
	end

	vm:set_data(data)
	vm:set_lighting({day = 0, night = 0})
	vm:calc_lighting()
	vm:write_to_map()
end)

core.log("action", "[mapgen] Expanded mapgen registered (biomes: forest/desert/snow, early ores, trees, caves)")
