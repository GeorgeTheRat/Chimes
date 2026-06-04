SMODS.Joker {
    key = "fungi",
    name = "Fungi",
    pos = { x = 1, y = 1 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.discard then
            if G.GAME.current_round.discards_left == 1 then
                local card_front = pseudorandom_element(G.P_CARDS, pseudoseed("add_card"))
                local new_card = create_playing_card({
                    front = card_front,
                    center = G.P_CENTERS.c_base
                }, G.discard, true, false, nil, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        new_card:start_materialize()
                        G.play:emplace(new_card)
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        return true
                    end
                }))
                draw_card(G.play, G.deck, 90, "up")
                SMODS.calculate_context({
                    playing_card_added = true,
                    cards = {new_card}
                })
                return {
                    message = "Added Card!"
                }
            end
        end
    end
}