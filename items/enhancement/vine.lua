SMODS.Enhancement {
    key = "vine",
    name = "Vine",
    pos = { x = 7, y = 0 },
    config = {
        extra = {
            freeconsumableslots = 0,
            odds = 20
        }
    },
    atlas = "enhancement",
    weight = 3,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_overgrown
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "m_chm_vine")
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.repetition then
            return {
                repetitions = card.ability.extra.freeconsumableslots
            }
        end
        if context.main_scoring and context.cardarea == G.play then
            local overgrown_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == "j_chm_overgrown" then
                    overgrown_count = overgrown_count + 1
                end
            end
            local current_odds = card.ability.extra.odds * (2 ^ overgrown_count)
            if SMODS.pseudorandom_probability(card, "m_chm_vine", 1, current_odds) then
                card:set_ability(G.P_CENTERS.m_chm_overgrown)
                return {
                    message = "Card Modified!",
                    colour = G.C.BLUE
                }
            end
        end
    end,
    update = function(self, card, dtt)
        card.ability.extra.freeconsumableslots = (G.consumeables and G.consumeables.config.card_limit or 0) - #(G.consumeables and G.consumeables.cards or {})
    end
}