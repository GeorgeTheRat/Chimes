SMODS.Joker{
    key = "crayons",
    name = "Crayons",
    config = { extra = { play_size = 3 } },
    pos = { x = 8, y = 0 },
    cost = 5,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        return { vars = { card.ability.extra.play_size } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (#context.full_hand == card.ability.extra.play_size and G.GAME.current_round.hands_left == 0) then
                context.other_card:set_edition("e_foil", true)
                return {
                    message = "Foil!",
                    colour = G.C.DARK_EDITION
                }
            end
        end
    end
}