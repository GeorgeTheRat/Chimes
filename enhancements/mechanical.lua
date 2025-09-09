SMODS.Enhancement {
    key = 'mechanical',
    pos = { x = 2, y = 0 },
    config = {
        extra = {
            xmult = 1.5
        }
    },
    loc_txt = {
        name = 'Mechanical',
        text = {
        [1] = 'Gains {X:red,C:white}X0.4{} Mult when held in hand at end of round',
        [2] = 'Decreases by {X:red,C:white}X0.05{} Mult when scored',
        [3] = '{C:inactive}(Currently {X:red,C:white}X#1#{} mult){}'
    }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            card.ability.extra.xmult = math.max(0, (card.ability.extra.xmult) - 0.05)
            SMODS.calculate_effect({x_mult = card.ability.extra.xmult}, card)
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Downgrade!", colour = G.C.RED})
        end
        if context.end_of_round and context.cardarea == G.hand and context.other_card == card and context.individual then
            return { func = function()
                    card.ability.extra.xmult = (card.ability.extra.xmult) + 0.4
                    return true
                end }
        end
    end
}