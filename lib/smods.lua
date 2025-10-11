-- smods.atlas

SMODS.Atlas({
    key = "modicon", 
    path = "icon.png", 
    px = 34,
    py = 34,
})

SMODS.Atlas({
    key = "joker", 
    path = "joker.png", 
    px = 71,
    py = 95, 
})

SMODS.Atlas({
    key = "consumable", 
    path = "consumable.png", 
    px = 71,
    py = 95, 
})

SMODS.Atlas({
    key = "booster", 
    path = "booster.png", 
    px = 71,
    py = 95, 
})

SMODS.Atlas({
    key = "enhancement", 
    path = "enhancement.png", 
    px = 71,
    py = 95, 
})

-- smods.objecttype

SMODS.ConsumableType({
    key = "Lenormand",
    primary_colour = { 0.933, 0.827, 0.624, 1 },
    secondary_colour = { 0.683, 0.577, 0.374, 1 },
    collection_rows = { 6, 6 },
    shop_rate = 2,
    default = "c_chm_rider"
})

SMODS.ObjectType({
    key = "sushi",
    default = "c_chm_californiaroll"
})

SMODS.ObjectType({
    key = "costumes",
    default = "c_chm_ghostcostume"
})