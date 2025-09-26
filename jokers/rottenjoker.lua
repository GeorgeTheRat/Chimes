SMODS.Joker{ --Rotten Joker
    key = "rottenjoker",
    config = {
        extra = {
            Xmult = 0.75,
            dollars = 6
        }
    },
    loc_txt = {
        ['name'] = 'Rotten Joker',
        ['text'] = {
            [1] = '{C:attention}Rotten Cards{} give {C:money}$6{}',
            [2] = 'and {X:red,C:white}X0.75{} Mult when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 2
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
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_solo_rotten"] == true then
                return {
                    Xmult = card.ability.extra.Xmult,
                    extra = {
                        dollars = card.ability.extra.dollars,
                        colour = G.C.MONEY
                        }
                }
            end
        end
    end
}