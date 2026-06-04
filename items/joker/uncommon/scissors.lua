SMODS.Joker{
    key = "scissors",
    name = "Scissors",
    config = {
        extra = {
            xmult = 0.5,
            mult = 40
        }
    },
    pos = { x = 2, y = 3 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
                extra = {
                    mult = card.ability.extra.mult
                }
            }
        end
    end
}