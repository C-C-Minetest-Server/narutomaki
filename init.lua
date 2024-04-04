-- narutomaki/init.lua
-- Delicious Narutomaki!
-- Copyright (C) 2024  1F616EMO
-- SPDX-License-Identifier: LGPL-2.1-or-later

local S = minetest.get_translator("narutomaki")

local def = {
	description = S("Narutomaki"),
	inventory_image = "narutomaki_narutomaki.png",
	groups = { food = 2, eatable = 4, },
}

local eat = minetest.item_eat(4)
if minetest.get_modpath("mcl_hunger") then
	def._mcl_saturation = 2.4 -- cf. Apple
	def.on_place = eat
	def.on_secondary_use = eat
else
	def.on_use = eat
end

minetest.register_craftitem("narutomaki:narutomaki", def)

local insert = table.insert
local fishes, flours = {}, {}
local pink_dye

if minetest.get_modpath("ethereal") then
	insert(fishes, "group:food_fish_raw")
end
if minetest.get_modpath("mcl_fishing") then
	insert(fishes, "mcl_fishing:salmon_raw")
end

if minetest.get_modpath("farming") then
	insert(flours, "group:food_flour")
end
if minetest.get_modpath("mcl_farming") then
	insert(flours, "mcl_farming:wheat_item")
end

if minetest.get_modpath("dye") then
	pink_dye = "dye:pink"
elseif minetest.get_modpath("mcl_dye") then
	pink_dye = "mcl_dye:pink"
end

local use_technic = minetest.get_modpath("technic") and technic.register_alloy_recipe and true or false
for _, fish in ipairs(fishes) do
	for _, flour in ipairs(flours) do
		local recipe = { fish, flour }
		if pink_dye then
			insert(recipe, pink_dye)
		end

		minetest.register_craft({
			type = "shapeless",
			recipe = recipe,
			output = "narutomaki:narutomaki 2",
		})
	end
end
