SMODS.Joker {
    key = "paper",
    name = "Paper",
    config = {
        extra = {
            mult = -15,
            chips = 200
        }
    },
    pos = { x = 5, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                extra = {
                    chips = card.ability.extra.chips
                }
            }
        end
    end
}