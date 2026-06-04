SMODS.Enhancement {
    key = "literature",
    name = "Literature",
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            chips = 20,
            chips_mod = 10
        }
    },
    atlas = "enhancement",
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_mod
            }
        }
    end, 
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.main_scoring then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.discard and context.other_card == card then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {
                message = "Upgrade!",
                colour = G.C.CHIPS
            }
        end
        if context.main_scoring and context.cardarea == G.play then
            if next(SMODS.find_card("j_chm_figure_1")) then
                return { 
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}