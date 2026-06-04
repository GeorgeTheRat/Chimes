SMODS.Enhancement {
    key = "rotten",
    name = "Rotten",
    pos = { x = 6, y = 0 },
    config = {
        extra = {
            xmult = 1.75,
            dollars = 3
        }
    },
    atlas = "enhancement",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local rotten_joker = SMODS.find_card("j_chm_rotten")[1]
            if rotten_joker then
                return {
                    xmult = rotten_joker.ability.extra.xmult,
                    dollars = rotten_joker.ability.extra.dollars
                }
            else
                return {
                    xmult = card.ability.extra.xmult,
                    dollars = -card.ability.extra.dollars
                }
            end
        end
    end
}