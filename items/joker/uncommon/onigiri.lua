SMODS.Joker {
    key = "onigiri",
    name = "Onigiri",
    config = {
        extra = {
            chips = 75,
            chips_mod = 15,
            voucher_slots = 1
        }
    },
    pos = { x = 2, y = 2 },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_mod,
                card.ability.extra.voucher_slots
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.pre_discard and not context.blueprint then
            if (card.ability.extra.chips - card.ability.extra.chips_mod) <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chips_mod",
                    operation = "-",
                    scaling_message = {
                        message = "Downgrade!",
                        colour = G.C.RED
                    }
                })
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_voucher_limit(card.ability.extra.voucher_slots)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_voucher_limit(-card.ability.extra.voucher_slots)
    end
}