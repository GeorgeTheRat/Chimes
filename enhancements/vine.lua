SMODS.Enhancement {
    key = 'vine',
    pos = { x = 7, y = 0 },
    config = {
        extra = {
            freeconsumableslots = 0,
            pprob = 20,
            odds = 1
        }
    },
    loc_txt = {
        name = 'Vine',
        text = {
        [1] = 'Retrigger this card {C:attention}once{} for',
        [2] = 'every free consumable slot',
        [3] = '{C:green}#2# in #1# {}chance of becoming an',
        [4] = '{C:attention}Overgrown Card{} when scored,',
        [5] = 'chance increases with each free consumable slot'
    }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = false,
    no_rank = true,
    no_suit = true,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 3,
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
        if context.main_scoring and context.cardarea == G.play and (function()
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.key == "j_overgrownjoker" then
            return true
        end
    end
    return false
end)() then
            card.ability.extra.pprob = 40
        end
        if context.main_scoring and context.cardarea == G.play and (function()
    for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.key == "j_overgrownjoker" then
            return false
        end
    end
    return true
end)() then
            card.ability.extra.pprob = 20
        end
    end
}