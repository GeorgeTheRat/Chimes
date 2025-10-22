if not Chimes then
	Chimes = {}
end

local files = {
    -- load lib/smods.lua first
    "lib/smods",
    -- then everything else
    "items/consumable/Lenormand",
    "items/joker/common",
    "items/joker/uncommon",
    "items/joker/rare",
    "items/joker/legendary",
    "items/booster",
    "items/enhancement",
    "lib/compat",
    "lib/no",
    "lib/random_consumable",
}
for i, v in pairs(files) do
	assert(SMODS.load_file(v..".lua"))()
end