SMODS.Joker{ --Train Ticket
    key = "newjoker",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ["name"] = "Train Ticket",
        ["text"] = {
            [1] = "{C:red}+2{} Discards when",
            [2] = "{C:attention}Third{} hand is played"
        },
        ["unlock"] = {
            [1] = "Unlocked by default."
        }
    },
    pos = {
        x = 0,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = "joker",
    pools = { ["chm_chm_jokers"] = true }
}