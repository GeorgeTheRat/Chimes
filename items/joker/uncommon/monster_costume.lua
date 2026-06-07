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
        if context.before and SMODS.pseudorandom_probability(card, "j_chm_monster_costume", 1, card.ability.extra.odds) then
            local enhancement_pool = {}
            for _, enhancement in pairs(G.P_CENTER_POOLS.Enhanced) do
                if not enhancement.overrides_base_rank then
                    enhancement_pool[#enhancement_pool + 1] = enhancement
                end
            end
            for _, scored_card in ipairs(context.scoring_hand) do
                scored_card:set_ability(pseudorandom_element(enhancement_pool, "j_chm_monster_costume"))
                G.E_MANAGER:add_event(Event({
                    func = function()
                        scored_card:juice_up()
                        return true
                    end
                }))
            end
            return {
                message = "Enhanced!",
                colour = G.C.BLUE
            }
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
                            key_append = "j_bof_monster_costume",
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