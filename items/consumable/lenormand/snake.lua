SMODS.Consumable {
    key = "snake",
    name = "Snake",
    set = "Lenormand",
    pos = { x = 6, y = 0 },
    config = {
        extra = {
            odds = 3,
            destroy = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "c_chm_snake")
        return {
            vars = { 
                numerator,
                denominator,
                card.ability.extra.destroy
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and G.hand.cards
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}
        for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )
        pseudoshuffle(temp_hand, "c_chm_snake")
        for i = 1, G.hand.config.card_limit do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end
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
        if SMODS.pseudorandom_probability(card, "c_chm_snake", 1, card.ability.extra.odds) then
            local destructable_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and
                    not G.jokers.cards[i].getting_sliced then
                    destructable_jokers[#destructable_jokers + 1] = G.jokers.cards[i]
                end
            end
            local joker_to_destroy = pseudorandom_element(destructable_jokers, "c_chm_snake")
            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                        return true
                    end
                }))
            end
        end
    end
}