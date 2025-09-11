SMODS.Joker{ --Wonders
    key = "wonders",
    config = {
        extra = {
            r = 11,
            var1 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Wonders',
        ['text'] = {
            [1] = 'Played {C:attention}7s{} give between {X:red,C:white}X1.1{}',
            [2] = 'and {X:red,C:white}X1.7{} Mult when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
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
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 7 then
                card.ability.extra.var1 = (card.ability.extra.var1) + pseudorandom('var1_776df99f', 11, 17)
                card.ability.extra.r = (card.ability.extra.r) * 0.1
                return {
                    Xmult = card.ability.extra.r
                }
            end
        end
    end
}