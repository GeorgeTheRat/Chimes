SMODS.Joker {
    key = "waterfall",
    name = "Waterfall",
    config = { extra = { retriggers = 0 } },
    pos = { x = 3, y = 4 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.tag_negative
        return { vars = { card.ability.extra.retriggers } }
    end,
    calculate = function(self, card, context)
        if context.after and context.scoring_name == "Two Pair" then
            card.ability.extra.retriggers = card.ability.extra.retriggers + 1
            return {
                message = "Upgrade!",
                colour = G.C.ATTENTION
            }
        end
        if context.repetition then
            if (
                context.other_card:get_id() == 10 or
                context.other_card:get_id() == 9 or
                context.other_card:get_id() == 8 or
                context.other_card:get_id() == 7 or
                context.other_card:get_id() == 6
            ) then
                return {
                    repetitions = card.ability.extra.retriggers,
                    message = localize("k_again_ex")
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            card.ability.extra.retriggers = 0
            return {
                message = "Reset!",
                colour = G.C.ATTENTION
            }
        end
    end
}
