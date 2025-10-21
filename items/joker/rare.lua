SMODS.Joker{
    key = "bonsai",
    name = "Bonsai",
    config = {
        extra = {
            odds = 10,
            create = 1
        }
    },
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
                denominator,
                card.ability.extra.create
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.other_card:is_suit("Hearts") and SMODS.pseudorandom_probability(card, "j_chm_bonsai", 1, card.ability.extra.odds) then
            for i = 1, math.min(card.ability.extra.create, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        play_sound("timpani")
                        card:juice_up(0.3, 0.5)
                        SMODS.add_card({ set = "Lenormand" })
                        return true 
                    end
                }))
            end
            return {
                message = "+" .. tostring(card.ability.extra.create) .. " Lenormand",
                colour = G.C.SECONDARY_SET.Lenormand
            }
        end
    end
}

SMODS.Joker {
    key = "orchid",
    name = "Orchid",
    config = {
        extra = {
            odds = 10,
            create = 1
        }
    },
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
                denominator,
                card.ability.extra.create
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