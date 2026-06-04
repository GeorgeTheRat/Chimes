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
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Spades") and SMODS.pseudorandom_probability(card, "j_chm_orchid", 1, card.ability.extra.odds) then
            for i = 1, math.ceil(card.ability.extra.create) do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            play_sound("timpani")
                            card:juice_up(0.3, 0.5)
                            SMODS.add_card({
                                set = "Spectral",
                                key_append = "j_chm_orchid"
                            })
                        end
                        return true
                    end
                }))
            end
            return {
                message = "+" .. tostring(card.ability.extra.create) .. " Spectral" .. (card.ability.extra.create > 1 and "s" or ""),
                colour = G.C.SECONDARY_SET.Spectral,
                card = context.other_card
            }
        end
    end
}