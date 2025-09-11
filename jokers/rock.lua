SMODS.Joker{ --Rock
    key = "rock",
    config = {
        extra = {
            chips = -100,
            Xmult = 3
        }
    },
    loc_txt = {
        ['name'] = 'Rock',
        ['text'] = {
            [1] = '{X:red,C:white}X4{} Mult',
            [2] = '{C:blue}-100{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 3
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
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        Xmult = card.ability.extra.Xmult
                        }
                }
        end
    end
}