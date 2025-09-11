SMODS.Joker{ --Scissors
    key = "scissors",
    config = {
        extra = {
            Xmult = 0.5,
            mult = 30
        }
    },
    loc_txt = {
        ['name'] = 'Scissors',
        ['text'] = {
            [1] = '{X:red,C:white}X0.5{} Mult',
            [2] = '{C:red}+30{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
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
                    Xmult = card.ability.extra.Xmult,
                    extra = {
                        mult = card.ability.extra.mult
                        }
                }
        end
    end
}