-- Nodes mod
-- Day 2: Basic nodes - soil (dirt), turf (grass), cragstone (stone), timber (wood), foliage (leaves)
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
