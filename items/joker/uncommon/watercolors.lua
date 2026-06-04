SMODS.Joker{
    key = "watercolors",
    name = "Watercolors",
    config = { extra = { play_size = 2 } },
    pos = { x = 2, y = 4 },
    cost = 5,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        return { vars = { card.ability.extra.play_size } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (#context.full_hand == card.ability.extra.play_size and G.GAME.current_round.hands_left == 0) then
                context.other_card:set_edition("e_holo", true)
                return {
                    message = "Holographic!",
                    colour = G.C.DARK_EDITION
                }
            end
        end
    end
}