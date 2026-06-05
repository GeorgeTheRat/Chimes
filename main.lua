if not Chimes then
	Chimes = {}
end

-- load all lib files first
local files = NFS.getDirectoryItemsInfo(SMODS.current_mod.path .. "/lib")
for i = 1, #files do
    local file_name = files[i].name
    if file_name:sub(-4) == ".lua" then
        assert(SMODS.load_file("lib/" .. file_name))()
    end
end

local files = {
    booster = {
        "items/booster/lenormand",
        "items/booster/jumbo_lenormand",
        "items/booster/mega_lenormand",
    },
    consumable = {
        lenormand = {
            "items/consumable/lenormand/rider",
            "items/consumable/lenormand/clover",
            "items/consumable/lenormand/ship",
            "items/consumable/lenormand/house",
            "items/consumable/lenormand/tree",
            "items/consumable/lenormand/clouds",
            "items/consumable/lenormand/snake",
            "items/consumable/lenormand/coffin",
            "items/consumable/lenormand/flowers",
            "items/consumable/lenormand/scythe",
            "items/consumable/lenormand/whip",
            "items/consumable/lenormand/birds",
            "items/consumable/lenormand/child",
            "items/consumable/lenormand/fox",
            "items/consumable/lenormand/bear",
            "items/consumable/lenormand/stars",
            "items/consumable/lenormand/stork",
            "items/consumable/lenormand/dog",
            "items/consumable/lenormand/tower",
            "items/consumable/lenormand/garden",
            "items/consumable/lenormand/mountain",
            "items/consumable/lenormand/crossroads",
            "items/consumable/lenormand/mice",
            "items/consumable/lenormand/heart",
            "items/consumable/lenormand/ring",
            "items/consumable/lenormand/book",
            "items/consumable/lenormand/letter",
            "items/consumable/lenormand/man",
            "items/consumable/lenormand/lady",
            "items/consumable/lenormand/lily",
            "items/consumable/lenormand/sun",
            "items/consumable/lenormand/moon",
            "items/consumable/lenormand/key",
            "items/consumable/lenormand/fish",
            "items/consumable/lenormand/anchor",
            "items/consumable/lenormand/cross"
        }
    },
    enhancement = {
        "items/enhancement/doodle",
        "items/enhancement/literature",
        "items/enhancement/mechanical",
        "items/enhancement/old",
        "items/enhancement/ricochet",
        "items/enhancement/rotten",
        "items/enhancement/vine",
        "items/enhancement/overgrown"
    },
    joker = {
        common = {
            "items/joker/common/bingo_card",
            "items/joker/common/figure_1",
            "items/joker/common/go_fish",
            "items/joker/common/keychain",
            "items/joker/common/makisu",
            "items/joker/common/punk",
            "items/joker/common/rotten",
            "items/joker/common/salmon_nigiri",
            "items/joker/common/tamago",
            "items/joker/common/train_ticket"
        },
        uncommon = {
            "items/joker/uncommon/alarm",
            "items/joker/uncommon/batteries",
            "items/joker/uncommon/brain",
            "items/joker/uncommon/california_roll",
            "items/joker/uncommon/chocolate_strawberry",
            "items/joker/uncommon/colored_pencils",
            "items/joker/uncommon/crayons",
            "items/joker/uncommon/elites",
            "items/joker/uncommon/fungi",
            "items/joker/uncommon/garlic",
            "items/joker/uncommon/ghost_costume",
            "items/joker/uncommon/hand_roll",
            "items/joker/uncommon/koi",
            "items/joker/uncommon/monster_costume",
            "items/joker/uncommon/motherboard",
            "items/joker/uncommon/onigiri",
            "items/joker/uncommon/paper",
            "items/joker/uncommon/pumpkin_costume",
            "items/joker/uncommon/rock",
            "items/joker/uncommon/scissors",
            "items/joker/uncommon/tobiko",
            "items/joker/uncommon/toy_car",
            "items/joker/uncommon/trickster",
            "items/joker/uncommon/wallbang",
            "items/joker/uncommon/watercolors",
            "items/joker/uncommon/waterfall",
            "items/joker/uncommon/wine",
            "items/joker/uncommon/wonders"
        },
        rare = {
            "items/joker/rare/bonsai",
            "items/joker/rare/botton_pon",
            "items/joker/rare/celosia",
            "items/joker/rare/orchid",
            "items/joker/rare/overgrown",
            "items/joker/rare/tako_nigiri",
            "items/joker/rare/togarashi",
        }
    }
}

for _, name in ipairs(files["booster"]) do
    assert(SMODS.load_file(name .. ".lua"))()
end

for _, name in ipairs(files["consumable"].lenormand) do
    assert(SMODS.load_file(name .. ".lua"))()
end

for _, name in ipairs(files["enhancement"]) do
    assert(SMODS.load_file(name .. ".lua"))()
end

for _, name in ipairs(files["joker"].common) do
    assert(SMODS.load_file(name .. ".lua"))()
end

for _, name in ipairs(files["joker"].uncommon) do
    assert(SMODS.load_file(name .. ".lua"))()
end

for _, name in ipairs(files["joker"].rare) do
    assert(SMODS.load_file(name .. ".lua"))()
end