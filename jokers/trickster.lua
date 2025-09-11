SMODS.Joker{ --Trickster
    key = "trickster",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Trickster',
        ['text'] = {
            [1] = '{C:attention}+1{}{C:attention} Booster Pack {}slot'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(-1)
    end
}