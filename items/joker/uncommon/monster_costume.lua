SMODS.Joker {
    key = "monster_costume",
    name = "Monster Costume",
    config = {
        extra = {
            odds = 5,
            dollars = 10,
        }
    },
    pos = { x = 0, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    pools = { ["costumes"] = true },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_monster_costume")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, "j_chm_monster_costume", 1, card.ability.extra.odds) then
                local enhancement_pool = {}
                for _, enhancement in pairs(G.P_CENTER_POOLS.Enhanced) do
                    if not enhancement.overrides_base_rank then
                        enhancement_pool[#enhancement_pool + 1] = enhancement
                    end
                end
                local random_enhancement = pseudorandom_element(enhancement_pool, "edit_card_enhancement")
                context.other_card:set_ability(random_enhancement)
                return {
                    message = "Card Modified!",
                    colour = G.C.BLUE,
                    card = context.other_card
                }
            end
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
                }
            }
        end
    end
}