SMODS.Enhancement {
    key = 'vine',
    pos = { x = 7, y = 0 },
    config = {
        extra = {
            freeconsumableslots = 0,
            odds = 20
        }
    },
    loc_txt = {
        name = 'Vine',
        text = {
        [1] = 'Retrigger this card {C:attention}once{} for',
        [2] = 'every free consumable slot',
        [3] = '{C:green}#1# in #3# {}chance of becoming an',
        [4] = '{C:attention}Overgrown Card{} when scored,',
        [5] = 'chance increases with empty consumable slots'
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
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'm_solo_vine')
        return {vars = {((G.consumeables and G.consumeables.config.card_limit or 0 - #(G.consumeables and G.consumeables.cards or {})) or 0), numerator, denominator}}
    end,
    calculate = function(self, card, context)
        if context.repetition and card.should_retrigger then
            return { repetitions = card.ability.extra.retrigger_times }
        end
        if context.main_scoring and context.cardarea == G.play then
            card.should_retrigger = false
            card.should_retrigger = true
            card.ability.extra.retrigger_times = (G.consumeables and G.consumeables.config.card_limit or 0 - #(G.consumeables and G.consumeables.cards or {}))
            if SMODS.pseudorandom_probability(card, 'group_0_e03c7077', 1, card.ability.extra.odds, 'm_solo_vine') then
                card:set_ability(G.P_CENTERS.m_solo_overgrowncard)
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.BLUE})
            end
        end
    end
}