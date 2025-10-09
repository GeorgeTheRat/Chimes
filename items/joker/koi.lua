SMODS.Joker{ --Koi
    key = "koi",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ["name"] = "Koi",
        ["text"] = {
            [1] = "Played cards gain {C:blue}+2{} {C:attention}held",
            [2] = "in hand{} chips when scored,",
            [3] = "increases by {C:attention}1{} when a",
            [4] = "{C:attention}Wild Card{} is discarded"
        },
        ["unlock"] = {
            [1] = "Unlocked by default."
        }
    },
    pos = {
        x = 7,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = "joker",
    pools = { ["chm_chm_jokers"] = true }
}