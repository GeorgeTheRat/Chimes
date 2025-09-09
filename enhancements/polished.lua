SMODS.Enhancement {
    key = 'polished',
    pos = { x = 5, y = 0 },
    config = {
        extra = {
            card_draw = 2
        }
    },
    loc_txt = {
        name = 'Polished',
        text = {
        [1] = 'Draw {C:attention}2{} additional cards when {C:red}discarded{}'
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
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            if G.GAME.blind.in_blind then
    SMODS.draw_cards(card.ability.extra.card_draw)
  end
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.card_draw).." Cards Drawn", colour = G.C.BLUE})
        end
    end
}