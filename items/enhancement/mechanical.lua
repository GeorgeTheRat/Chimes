SMODS.Enhancement {
    key = "mechanical",
    name = "Mechanical",
    pos = { x = 2, y = 0 },
    config = {
        x_mult = 1,
        extra = {
            x_mult_mod = 0.5
        }
    },
    atlas = "enhancement",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.x_mult,
                card.ability.extra.x_mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            card.ability.x_mult = card.ability.x_mult + card.ability.extra.x_mult_mod
            return {
                message = "Upgrade!",
                colour = G.C.RED
            }
        end
        if context.after and context.cardarea == G.play and card.ability.x_mult ~= 1 then
            card.ability.x_mult = 1
            return {
                message = "Reset!",
                colour = G.C.RED
            }
        end
    end
}