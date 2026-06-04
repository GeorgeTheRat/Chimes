SMODS.Joker {
    key = "rock",
    name = "Rock",
    config = {
        extra = {
            chips = -100,
            xmult = 3
        }
    },
    pos = { x = 9, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                extra = {
                    xmult = card.ability.extra.xmult
                }
            }
        end
    end
}