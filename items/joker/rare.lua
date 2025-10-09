SMODS.Joker{
    key = "bonsai",
    name = "Bonsai",
    config = { extra = { odds = 10 } },
    pos = { x = 3, y = 0 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.other_card:is_suit("Hearts") and SMODS.pseudorandom_probability(card, "j_chm_bonsai", 1, card.ability.extra.odds, "j_chm_bonsai") then
            for i = 1, math.min(undefined, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("timpani")
                    SMODS.add_card({ set = "Lenormand" })                            
                    card:juice_up(0.3, 0.5)
                    return true
                end
                }))
            end
        end
    end
}