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

SMODS.Joker {
    key = "orchid",
    name = "Orchid",
    config = { extra = { odds = 10 } },
    pos = { x = 3, y = 2 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
        loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_orchid")
        return {
            vars = { 
                numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Spades") and #G.consumeables.cards < G.consumeables.config.card_limit and SMODS.pseudorandom_probability(card, "j_chm_orchid", 1, card.ability.extra.odds) then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    SMODS.add_card({
                        set = "Spectral",
                        key_append = "chm_orchid"
                    })
                    return true
                end
            }))
            return {
                message = localize("k_plus_spectral"),
                colour = G.C.SECONDARY_SET.Spectral
            }
        end
    end
}

SMODS.Joker {
    key = "overgrownjoker",
    config = { extra = { slots = 3 } },
    pos = { x = 4, y = 2 },
    cost = 5,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
    end
}