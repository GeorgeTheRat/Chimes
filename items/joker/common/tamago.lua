SMODS.Joker {
    key = "tamago",
    name = "Tamago",
    config = {
        extra = {
            dollars = 10,
            dollars_mod = 2,
            sell_value_mod = 4,
        }
    },
    pos = { x = 5, y = 3 },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    pools = { ["sushi"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.dollars_mod,
                card.ability.extra.sell_value_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            ease_dollars(card.ability.extra.dollars)
        end
        if context.skip_blind then
            if card.ability.extra.dollars - card.ability.extra.dollars_mod <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                local pos = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        pos = i
                        break
                    end
                end
                local target_card = (pos and pos < #G.jokers.cards) and G.jokers.cards[pos + 1] or nil
                if target_card then
                    target_card.ability.extra_value = (target_card.ability.extra_value or 0) + card.ability.extra.sell_value_mod
                    target_card:set_cost()
                    card.ability.extra.dollars = math.max(0, card.ability.extra.dollars - card.ability.extra.dollars_mod)
                    return {
                        message = "Value Up!",
                        colour = G.C.MONEY,
                    }
                else
                    card.ability.extra.dollars = math.max(0, card.ability.extra.dollars - card.ability.extra.dollars_mod)
                end
            end
        end
    end
}