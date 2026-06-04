SMODS.Consumable {
    key = "ship",
    name = "Ship",
    set = "Lenormand",
    pos = { x = 2, y = 0 },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                (G.hand and G.hand.config and G.hand.config.card_limit) or 8
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}
        for _, playing_card in ipairs(G.hand.cards) do
            temp_hand[#temp_hand + 1] = playing_card
        end
        table.sort(
            temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )
        pseudoshuffle(temp_hand, "c_chm_ship")
        for i = 1, (G.hand.config.card_limit or 8) do
            destroyed_cards[#destroyed_cards + 1] = temp_hand[i]
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        SMODS.destroy_cards(destroyed_cards)
        delay(0.3)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, (G.hand.config.card_limit or 8) do
                    local _rank = pseudorandom_element(SMODS.Ranks, "add_random_rank").card_key
                    local _suit = nil
                    local new_card_params = {
                        set = "Base"
                    }
                    if _rank then
                        new_card_params.rank = _rank
                    end
                    if _suit then
                        new_card_params.suit = _suit
                    end
                    cards[i] = SMODS.add_card(new_card_params)
                end
                SMODS.calculate_context({
                    playing_card_added = true,
                    cards = cards
                })
                return true
            end
        }))
        delay(0.5)
    end
}