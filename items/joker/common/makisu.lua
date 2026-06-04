SMODS.Joker {
    key = "makisu",
    name = "Makisu",
    pos = { x = 9, y = 1 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.using_consumeable and G.GAME.blind.boss then
            local created_joker = false
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                created_joker = true
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local joker_card = SMODS.add_card({ set = "sushi" })
                        if joker_card then
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))
            end
            if created_joker then
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.BLUE
                }
            end
        end
    end
}