SMODS.Joker {
    key = "ghost_costume",
    name = "Ghost Costume",
    config = {
        extra = {
            odds = 13,
            dollars = 10,
        }
    },
    pos = { x = 3, y = 1 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    pools = { ["costumes"] = true },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_ghost_costume")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, "j_chm_ghost_costume", 1, card.ability.extra.odds) then
            local random_edition = poll_edition("edit_card_edition", nil, true, true)
            if random_edition then
                context.other_card:set_edition(random_edition, true)
            end
            return {
                message = "Card Modified!",
                colour = G.C.BLUE
            }
        end
        if context.selling_self then
            return {
                dollars = -card.ability.extra.dollars,
                extra = {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = "costumes" })
                                    if joker_card then
                                        G.GAME.joker_buffer = 0
                                    end
                                    return true
                                end
                            }))
                        end
                        if created_joker then
                            return {
                                message = "+1 Joker",
                                colour = G.C.BLUE
                            }
                        end
                        return true
                    end
                }
            }
        end
    end
}