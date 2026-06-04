SMODS.Joker {
    key = "hand_roll",
    name = "Hand Roll",
    config = {
        extra = {
            plushands = 4,
            plusdollars = 4,
            plushands_mod = 1,
            plusdollars_mod = 1
        }
    },
    pos = { x = 5, y = 1 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.plushands,
                card.ability.extra.plusdollars,
                card.ability.extra.plushands_mod,
                card.ability.extra.plusdollars_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            SMODS.scale_card(card, {
                ref_table = G.GAME.current_round,
                ref_value = "hands_left",
                scalar_table = card.ability.extra,
                scalar_value = "plushands",
                scaling_message = {
                    message = "+" .. tostring(card.ability.extra.plushands) .. " Hand" .. (card.ability.extra.plushands > 1 and "s" or ""),
                    colour = G.C.BLUE
                }
            })
        end
        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            if (card.ability.extra.plushands - card.ability.extra.plushands_mod <= 0) or (card.ability.extra.plusdollars - card.ability.extra.plusdollars_mod <= 0) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "plushands",
                    scalar_value = "plushands_mod",
                    operation = "-",
                    scaling_message = {
                        message = "-" .. tostring(card.ability.extra.plushands_mod) .. " Hand" .. (card.ability.extra.plushands_mod > 1 and "s" or ""),
                        colour = G.C.BLUE
                    }
                })
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "plusdollars",
                    scalar_value = "plusdollars_mod",
                    operation = "-",
                    scaling_message = {
                        message = "-$" .. tostring(card.ability.extra.plusdollars_mod),
                        colour = G.C.MONEY
                    }
                })
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        return G.GAME.current_round.hands_left * card.ability.extra.plusdollars
    end
}