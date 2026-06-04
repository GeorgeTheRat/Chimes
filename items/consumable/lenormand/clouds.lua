SMODS.Consumable {
    key = "clouds",
    name = "Clouds",
    set = "Lenormand",
    pos = { x = 5, y = 0 },
    config = {
        extra = {
            create_enhancement = 1,
            create_edition = 1,
            create_seal = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.create_enhancement,
                card.ability.extra.create_edition,
                card.ability.extra.create_seal
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.7,
            func = function()
                local cards = {}
                local card_ranks = {}
                local card_suits = {}
                for i = 1, 3 do
                    local valid_rank = false
                    local new_rank
                    while not valid_rank do
                        new_rank = pseudorandom_element(SMODS.Ranks, "clouds_rank_"..i).card_key
                        valid_rank = true
                        for _, rank in ipairs(card_ranks) do
                            if rank == new_rank then
                                valid_rank = false
                                break
                            end
                        end
                        if valid_rank then
                            table.insert(card_ranks, new_rank)
                        end
                    end
                end
                for i = 1, 3 do
                    local valid_suit = false
                    local new_suit
                    while not valid_suit do
                        new_suit = pseudorandom_element(SMODS.Suits, "clouds_suit_"..i).card_key
                        valid_suit = true
                        for _, suit in ipairs(card_suits) do
                            if suit == new_suit then
                                valid_suit = false
                                break
                            end
                        end
                        if valid_suit then
                            table.insert(card_suits, new_suit)
                        end
                    end
                end
                local card1 = SMODS.add_card({
                    set = "Base",
                    rank = card_ranks[1],
                    suit = card_suits[1]
                })
                if card1 then
                    local enhancement = SMODS.poll_enhancement({ mod = 10, guaranteed = true })
                    if enhancement then
                        card1:set_ability(enhancement)
                    end
                    table.insert(cards, card1)
                end
                local card2 = SMODS.add_card({
                    set = "Base",
                    rank = card_ranks[2],
                    suit = card_suits[2]
                })
                if card2 then
                    local edition = poll_edition("clouds_edition", nil, true, true, {"e_polychrome", "e_holo", "e_foil"})
                    card2:set_edition(edition, true)
                    table.insert(cards, card2)
                end
                local card3 = SMODS.add_card({
                    set = "Base",
                    rank = card_ranks[3],
                    suit = card_suits[3]
                })
                if card3 then
                    local seal = SMODS.poll_seal({mod = 10, guaranteed = true})
                    if seal then
                        card3:set_seal(seal, true)
                    end
                    table.insert(cards, card3)
                end
                SMODS.calculate_context({
                    playing_card_added = true,
                    cards = cards
                })
                return true
            end
        }))
        delay(0.3)
    end
}