SMODS.Joker {
    key = "wonders",
    name = "Wonders",
    config = {
        extra = {
            xmult = 1.3,
            dollars = 1
        }
    },
    pos = { x = 5, y = 4 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.individual and context.cardarea == G.hand and context.other_card:get_id() == 7 and not context.end_of_round then
            local count = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card.base.id == 7 then
                    count = count + 1
                end
            end
            if count > 0 then
                return {
                    dollars = count * card.ability.extra.dollars
                }
            end
        end
    end
}