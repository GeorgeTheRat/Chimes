SMODS.Joker {
    key = "motherboard",
    config = {
        extra = {
            chips_mod = 10,
            chips_mod_2 = 15,
            chips = 0
        }
    },
    pixel_size = { h = 71 },
    pos = { x = 1, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_mod,
                card.ability.extra.chips_mod_2,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.pseudorandom_result then
            if context.result then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chips_mod",
                    operation = function(ref_table, ref_value, initial, change)
                        ref_table[ref_value] = ref_table[ref_value] - change
                        if ref_table[ref_value] <= 0 then
                            ref_table[ref_value] = 0
                        end
                    end,
                    scaling_message = {
                        message = "Downgrade!",
                        colour = G.C.RED
                    }
                })
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chips_mod_2",
                    message_colour = G.C.CHIPS
                })
            end
        end
    end
}