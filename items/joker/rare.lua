SMODS.Joker{
    key = "bonsai",
    name = "Bonsai",
    config = { extra = { odds = 10 } },
    pos = { x = 3, y = 0 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_bonsai")
        return {
            vars = { 
                numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.other_card:is_suit("Hearts") and SMODS.pseudorandom_probability(card, "j_chm_bonsai", 1, card.ability.extra.odds) and G.consumeables.config.card_limit - #G.consumeables.cards then
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
}