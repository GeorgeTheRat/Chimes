SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
}):register()

SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()

SMODS.Atlas({
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()

SMODS.Atlas({
    key = "CustomBoosters", 
    path = "CustomBoosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()

SMODS.Atlas({
    key = "CustomEnhancements", 
    path = "CustomEnhancements.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end

local function load_jokers_folder()
    local mod_path = SMODS.current_mod.path
    local jokers_path = mod_path .. "/jokers"
    local files = NFS.getDirectoryItemsInfo(jokers_path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("jokers/" .. file_name))()
        end
    end
end

local function load_consumables_folder()
    local mod_path = SMODS.current_mod.path
    local consumables_path = mod_path .. "/consumables"
    local files = NFS.getDirectoryItemsInfo(consumables_path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("consumables/" .. file_name))()
        end
    end
end

local function load_enhancements_folder()
    local mod_path = SMODS.current_mod.path
    local enhancements_path = mod_path .. "/enhancements"
    local files = NFS.getDirectoryItemsInfo(enhancements_path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file("enhancements/" .. file_name))()
        end
    end
end

local function load_boosters_file()
    local mod_path = SMODS.current_mod.path
    assert(SMODS.load_file("boosters.lua"))()
end

load_boosters_file()
load_jokers_folder()
load_consumables_folder()
load_enhancements_folder()
SMODS.ObjectType({
    key = "solo_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true,
        ["j_solo_chocolatestrawberry"] = true,
        ["j_solo_garlic"] = true
    },
})

SMODS.ObjectType({
    key = "solo_solo_jokers",
    cards = {
        ["j_solo_bingocard"] = true,
        ["j_solo_cuecard1"] = true,
        ["j_solo_cuecard"] = true,
        ["j_solo_cuecard2"] = true,
        ["j_solo_keychain"] = true,
        ["j_solo_motherboard"] = true
    },
})

SMODS.ObjectType({
    key = "solo_sushi",
    cards = {
        ["j_solo_californiaroll"] = true,
        ["j_solo_makiroll"] = true,
        ["j_solo_salmonnigiri"] = true,
        ["j_solo_takonigiri"] = true,
        ["j_solo_tamago"] = true,
        ["j_solo_tobiko"] = true
    },
})

SMODS.ObjectType({
    key = "solo_costumes",
    cards = {
        ["j_solo_ghostcostume"] = true,
        ["j_solo_monstercostume"] = true
    },
})

SMODS.ObjectType({
    key = "solo_costumes2",
    cards = {
        ["j_solo_ghostcostume"] = true,
        ["j_solo_pumpkincostume"] = true
    },
})

SMODS.ObjectType({
    key = "solo_costumes1",
    cards = {
        ["j_solo_monstercostume"] = true,
        ["j_solo_pumpkincostume"] = true
    },
})