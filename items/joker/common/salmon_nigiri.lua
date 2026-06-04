SMODS.Joker {
    key = "salmon_nigiri",
    name = "Salmon Nigiri",
    config = {
        extra = {
            mult = 12,
            mult_mod = 1,
            h_mult_mod = 1,
        }
    },
    pos = { x = 1, y = 3 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    pools = { ["sushi"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_mod,
                card.ability.extra.h_mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.after and card.ability.extra.mult - card.ability.extra.mult_mod <= 0 then
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = localize("k_eaten_ex")
            }
        end
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_h_mult = context.other_card.ability.perma_h_mult + card.ability.extra.h_mult_mod
            card.ability.extra.mult = math.max(0, (card.ability.extra.mult) - 1)
            return {
                extra = {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.MULT
                },
                card = card
            }
        end
    end
}