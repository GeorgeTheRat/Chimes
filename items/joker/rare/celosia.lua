SMODS.Joker {
    key = "celosia",
    name = "Celosia",
    config = {
        extra = {
            odds = 10,
            create = 1
        }
    },
    pos = { x = 3, y = 3 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_celosia")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.create
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.other_card:is_suit("Diamonds") and SMODS.pseudorandom_probability(card, "j_chm_celosia", 1, card.ability.extra.odds) then
            for i = 1, math.ceil(card.ability.extra.create) do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit - #G.consumeables.cards >= 0 then
                            play_sound("timpani")
                            card:juice_up(0.3, 0.5)
                            SMODS.add_card({
                                set = "Tarot",
                                edition = "e_negative",
                                key_append = "chm_celosia"
                            })
                        end
                        return true 
                    end
                }))
            end
            return {
                message = "+" .. tostring(card.ability.extra.create) .. " Tarot" .. (card.ability.extra.create > 1 and "s" or ""),
                colour = G.C.SECONDARY_SET.Tarot,
                card = context.other_card
            }
        end
    end
}