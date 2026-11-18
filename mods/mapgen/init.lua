-- Mapgen mod
-- Day 3: Custom mapgen - surface + underground + basic caves (Terraria-style vertical layers)
-- Original implementation: layered terrain with turf surface, soil, cragstone underground, and simple cave carves

core.log("action", "[mapgen] Custom mapgen mod loaded")

-- Force singlenode mapgen so we fully control generation
minetest.set_mapgen_setting("mg_name", "singlenode", true)
minetest.set_mapgen_setting("water_level", "-31000", true) -- effectively no water for now

local c_air = minetest.get_content_id("air")
local c_soil = minetest.get_content_id("nodes:soil")
local c_turf = minetest.get_content_id("nodes:turf")
local c_stone = minetest.get_content_id("nodes:cragstone")

-- Base surface height (Y level)
local BASE_SURFACE = 8
local DIRT_DEPTH = 4

minetest.register_on_generated(function(minp, maxp, seed)
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()
	local pr = PseudoRandom(seed + minp.x + minp.z * 100)

	-- Generate layered terrain
	for z = minp.z, maxp.z do
		for x = minp.x, maxp.x do
			-- Simple height variation for natural surface (original math, no external noise libs)
			local height_var = math.floor(math.sin(x * 0.15) * 3 + math.cos(z * 0.12) * 2.5)
			local surface = BASE_SURFACE + height_var

			for y = minp.y, maxp.y do
				local vi = area:index(x, y, z)
				if y > surface then
					data[vi] = c_air
				elseif y == surface then
					data[vi] = c_turf
				elseif y > surface - DIRT_DEPTH then
					data[vi] = c_soil
				else
					data[vi] = c_stone
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
								if data[vi] == c_stone then
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

core.log("action", "[mapgen] Layered mapgen registered (surface turf/soil, underground cragstone, basic caves)")
