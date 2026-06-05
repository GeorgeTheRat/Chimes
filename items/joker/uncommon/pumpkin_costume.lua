SMODS.Joker {
    key = "pumpkin_costume",
    name = "Pumpkin Costume",
    config = {
        extra = {
            odds = 11,
            dollars = 10,
        }
    },
    pos = { x = 7, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    pools = { ["costumes"] = true, },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_pumpkin_costume")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            if SMODS.pseudorandom_probability(card, "j_chm_pumpkin_costume", 1, card.ability.extra.odds) then
                local random_seal = SMODS.poll_seal({
                    mod = 10,
                    guaranteed = true
                })
                if random_seal then
                    context.other_card:set_seal(random_seal, true)
                end
                return {
                    message = "Card Modified!",
                    colour = G.C.BLUE
                }
            end
        end
        if context.selling_self then
            ease_dollars(-card.ability.extra.dollars)
            local created_joker = false
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                created_joker = true
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local joker_card = SMODS.add_card({
                            set = "costumes",
                            area = G.jokers,
                            key_append = "j_chm_pumpkin_costume",
                        })
                        if joker_card then
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))
            end
            if created_joker then
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.BLUE
                }
            end
        end
    end
}