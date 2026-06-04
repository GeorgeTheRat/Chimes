SMODS.Joker{
    key = "train_ticket",
    name = "Train Ticket",
    config = { extra = { discards = 2 } },
    pos = { x = 0, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards } }
    end,
    calculate = function(self, card, context)
        if context.before then
            if G.GAME.current_round.hands_played == 2 then
                ease_discard(card.ability.extra.discards)
                return {
                    message = "+" .. card.ability.extra.discards .. " Discards",
                    colour = G.C.RED
                }
            end
        end
    end
}