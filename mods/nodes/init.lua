-- Nodes mod
-- Day 2: Basic nodes - soil (dirt), turf (grass), cragstone (stone), timber (wood), foliage (leaves)
-- Day 9: Added sand, snow, and early-tier ore nodes (original names)
-- All names and designs original

core.log("action", "[nodes] Nodes mod loaded")

-- Soil (dirt equivalent)
minetest.register_node("nodes:soil", {
	description = "Soil",
	tiles = {"nodes_soil.png"},
	groups = {crumbly = 3, soil = 1, oddly_breakable_by_hand = 1},
	is_ground_content = true,
})

-- Turf (grass equivalent)
minetest.register_node("nodes:turf", {
	description = "Turf",
	tiles = {"nodes_turf.png", "nodes_soil.png", "nodes_soil.png"},
	groups = {crumbly = 3, soil = 1, grass = 1, oddly_breakable_by_hand = 1},
	is_ground_content = true,
})

-- Cragstone (stone equivalent)
minetest.register_node("nodes:cragstone", {
	description = "Cragstone",
	tiles = {"nodes_cragstone.png"},
	groups = {cracky = 3, stone = 1},
	is_ground_content = true,
})

-- Timber (wood equivalent)
minetest.register_node("nodes:timber", {
	description = "Timber",
	tiles = {"nodes_timber.png"},
	groups = {choppy = 2, wood = 1, flammable = 2},
	is_ground_content = false,
})

-- Foliage (leaves equivalent)
minetest.register_node("nodes:foliage", {
	description = "Foliage",
	tiles = {"nodes_foliage.png"},
	groups = {snappy = 3, leaves = 1, flammable = 2},
	drawtype = "allfaces_optional",
	paramtype = "light",
	waving = 1,
	is_ground_content = false,
})

-- Sand (desert surface)
minetest.register_node("nodes:sand", {
	description = "Sand",
	tiles = {"nodes_soil.png"}, -- placeholder; original yellow sand texture later
	groups = {crumbly = 3, sand = 1, oddly_breakable_by_hand = 1},
	is_ground_content = true,
})

-- Snow (snow surface)
minetest.register_node("nodes:snow", {
	description = "Snow",
	tiles = {"nodes_turf.png"}, -- placeholder; original white snow texture later
	groups = {crumbly = 3, snow = 1, oddly_breakable_by_hand = 1},
	is_ground_content = true,
})

-- Early-tier ores (original names matching copper/iron/silver/gold progression feel)
-- Copral (copper-like, shallow)
minetest.register_node("nodes:copral_ore", {
	description = "Copral Ore",
	tiles = {"nodes_cragstone.png"}, -- placeholder; colored later
	groups = {cracky = 2, stone = 1, copral = 1},
	is_ground_content = true,
	drop = "nodes:copral_ore",
})

-- Ferrite (iron-like, mid-depth)
minetest.register_node("nodes:ferrite_ore", {
	description = "Ferrite Ore",
	tiles = {"nodes_cragstone.png"},
	groups = {cracky = 2, stone = 1, ferrite = 1},
	is_ground_content = true,
	drop = "nodes:ferrite_ore",
})

-- Argentite (silver-like, deeper)
minetest.register_node("nodes:argentite_ore", {
	description = "Argentite Ore",
	tiles = {"nodes_cragstone.png"},
	groups = {cracky = 2, stone = 1, argentite = 1},
	is_ground_content = true,
	drop = "nodes:argentite_ore",
})

-- Aurite (gold-like, deepest early)
minetest.register_node("nodes:aurite_ore", {
	description = "Aurite Ore",
	tiles = {"nodes_cragstone.png"},
	groups = {cracky = 1, stone = 1, aurite = 1},
	is_ground_content = true,
	drop = "nodes:aurite_ore",
})
