SMODS.Joker{ --Wonders
    key = "wonders",
    config = {
        extra = {
            r = 11,
            _7sinhand = 0,
            Xmult = 1.3
        }
    },
    loc_txt = {
        ['name'] = 'Wonders',
        ['text'] = {
            [1] = 'Played {C:attention}7s{} give {X:red,C:white}X1.3{} Mult when scored',
            [2] = '{C:attention}7s{} give {C:attention}$1{} while {C:attention}held in hand{}',
            [3] = 'for every {C:attention}7{} in played hand'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
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
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if context.other_card:get_id() == 7 then
                return {
                    dollars = (function() local count = 0; for _, card in ipairs(G.hand and G.hand.cards or {}) do if card.base.id == 7 then count = count + 1 end end; return count end)()
                }
            end
        end
    end
}