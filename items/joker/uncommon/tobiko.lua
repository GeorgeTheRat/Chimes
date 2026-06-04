SMODS.Joker {
    key = "tobiko",
    name = "Tobiko",
    config = {
        extra = {
            rerolls = 4,
            odds = 4,
            reroll_mod = 1,
            sell_value = 0,
        }
    },
    pos = { x = 6, y = 3 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    pools = { ["sushi"] = true },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_tobiko")
        return {
            vars = {
                card.ability.extra.rerolls,
                numerator,
                denominator,
                card.ability.extra.reroll_mod,
                card.ability.extra.sell_value,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.reroll_shop and SMODS.pseudorandom_probability(card, "tobiko_reroll_shop", 1, card.ability.extra.odds, "j_chm_tobiko", false) and not context.blueprint then
            if card.ability.extra.rerolls <= card.ability.extra.rerolls - card.ability.extra.reroll_mod then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                card.ability.extra.rerolls = math.max(0, card.ability.extra.rerolls - card.ability.extra.reroll_mod)
                if G.jokers and G.jokers.cards then
                    for _, j in ipairs(G.jokers.cards) do
                        if j == card then
                            SMODS.change_free_rerolls(-card.ability.extra.reroll_mod)
                            break
                        end
                    end
                end
                return {
                    message = "-" .. card.ability.extra.reroll_mod .. " Reroll" .. (card.ability.extra.reroll_mod > 1 and "s" or ""),
                    colour = G.C.GREEN
                }
            end
        end
        if context.selling_self then
            if G.jokers and G.jokers.cards then
                for _, target_card in ipairs(G.jokers.cards) do
                    if target_card ~= card and target_card.set_cost then
                        target_card.ability.extra_value = card.ability.extra.sell_value
                        target_card:set_cost()
                    end
                end
            end
            return {
                message = "Reset",
                colour = G.C.RED
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(card.ability.extra.rerolls)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(-(card.ability.extra.rerolls))
    end
}