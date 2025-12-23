SMODS.Consumable {
    key = "rider",
    name = "Rider",
    set = "Lenormand",
    pos = { x = 3, y = 2 },
    config = {
        extra = {
            tags = 2,
            dollars = 25
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_investment
        return {
            vars = {
                card.ability.extra.tags,
                card.ability.extra.dollars
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        for i = 1, card.ability.extra.tags do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local tag = Tag("tag_investment")
                    tag:set_ability()
                    add_tag(tag)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                ease_dollars(-card.ability.extra.dollars, true)
                return true
            end
        }))
        delay(0.6)
    end,
}

SMODS.Consumable {
    key = "clover",
    name = "Clover",
    set = "Lenormand",
    pos = { x = 5, y = 0 },
    config = { extra = { max_highlighted = 1 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_vine
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_chm_vine"])            
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "ship",
    name = "Ship",
    set = "Lenormand",
    pos = { x = 6, y = 2 },
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
        return G.hand
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

SMODS.Consumable {
    key = "house",
    name = "House",
    set = "Lenormand",
    pos = { x = 4, y = 1 },
    config = {
        extra = {
            perma_bonus_value = 30,
            max_highlighted = 2
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.perma_bonus_value,
                card.ability.extra.max_highlighted
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted 
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i].ability.perma_h_chips = G.hand.highlighted[i].ability.perma_h_chips or 0
                        G.hand.highlighted[i].ability.perma_h_chips = G.hand.highlighted[i].ability.perma_h_chips + card.ability.extra.perma_bonus_value
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "tree",
    name = "Tree",
    set = "Lenormand",
    pos = { x = 2, y = 3 },
    config = {
        extra = {
            dollars = 3,
            cardsremovedfromdeck = 0,
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                G.GAME.starting_deck_size or 52,
                math.max((G.playing_cards and (G.GAME.starting_deck_size - #G.playing_cards) or 0) * card.ability.extra.dollars, 0)
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                used_card:juice_up(0.3, 0.5)
                ease_dollars(math.max(0, (G.playing_cards and (G.GAME.starting_deck_size - #G.playing_cards) or 0) * card.ability.extra.dollars), true)
                return true
            end
        }))
        delay(0.6)
    end
}

SMODS.Consumable {
    key = "clouds",
    name = "Clouds",
    set = "Lenormand",
    pos = { x = 4, y = 3 },
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
        return G.hand
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
                    local enhancement = SMODS.poll_enhancement({mod = 10, guaranteed = true})
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
                    local edition = poll_edition("clouds_edition", nil, true, true, 
                        {"e_polychrome", "e_holo", "e_foil"})
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

SMODS.Consumable {
    key = "snake",
    name = "Snake",
    set = "Lenormand",
    pos = { x = 7, y = 2 },
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
        return true
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

SMODS.Consumable {
    key = "coffin",
    name = "Coffin",
    set = "Lenormand",
    pos = { x = 6, y = 0 },
    config = {
        extra = {
            destroy_count = 3,
            add_cards_count = 2
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.destroy_count,
                card.ability.extra.add_cards_count
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}
        for _, playing_card in ipairs(G.hand.cards) do
            temp_hand[#temp_hand + 1] = playing_card
        end
        table.sort(temp_hand, function(a, b)
            return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
        end)
        pseudoshuffle(temp_hand, "c_chm_coffin")
        for i = 1, 3 do
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
        delay(0.5)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, 2 do
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
                    if cards[i] then
                        local edition = poll_edition("add_cards_edition", nil, true, true,
                            {"e_polychrome", "e_holo", "e_foil"})
                        cards[i]:set_edition(edition, true)
                    end
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

SMODS.Consumable {
    key = "flowers",
    name = "Flowers",
    set = "Lenormand",
    pos = { x = 1, y = 1 },
    config = {
        extra = {
            destroy = 1,
            edition = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        return {
            vars = {
                card.ability.extra.destroy,
                card.ability.extra.edition
            }
        }
    end,
    can_use = function(self, card)
        return #G.jokers.cards > 0
    end,
    use = function(self, card, area, copier)
        local destructable_jokers = {}
        for i = 1, #G.jokers.cards do
            local joker = G.jokers.cards[i]
            if joker ~= card and not SMODS.is_eternal(joker, card) and not joker.getting_sliced then
                table.insert(destructable_jokers, joker)
            end
        end
        local joker_to_destroy = #destructable_jokers > 0 and 
            pseudorandom_element(destructable_jokers, "c_chm_flowers") or nil
        if joker_to_destroy then
            for _ = 1, card.ability.extra.destroy do
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
            end
        end
        local used_card = copier or card
        local jokers_to_edition = {}
        local eligible_jokers = {}
        for _, joker in ipairs(G.jokers.cards) do
            if joker ~= card and joker ~= joker_to_destroy and joker.ability.set == "Joker" and (not joker.edition or not joker.edition.holo) then
                table.insert(eligible_jokers, joker)
            end
        end
        if #eligible_jokers > 0 then
            local temp_jokers = {}
            for _, joker in ipairs(eligible_jokers) do
                table.insert(temp_jokers, joker)
            end
            pseudoshuffle(temp_jokers, 76543)
            local max_editions = math.min(card.ability.extra.edition, #temp_jokers)
            for i = 1, max_editions do
                table.insert(jokers_to_edition, temp_jokers[i])
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for _, joker in ipairs(jokers_to_edition) do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        joker:set_edition({ holo = true }, true)
                        return true
                    end
                }))
            end
            delay(0.6)
        else
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
        end
    end
}

SMODS.Consumable {
    key = "scythe",
    name = "Scythe",
    set = "Lenormand",
    pos = { x = 5, y = 2 },
    config = {
        extra = {
            destroy = 1,
            dollars = 10
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.destroy,
                card.ability.extra.dollars,
                math.floor(lenient_bignum(G.GAME.dollars / card.ability.extra.dollars)) or 0,
            }
        }
    end,
    can_use = function(self, card)
        return G.hand.cards
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        local destroyed_cards = {}
        local temp_hand = {}
        for _, playing_card in ipairs(G.hand.cards) do
            temp_hand[#temp_hand + 1] = playing_card
        end
        table.sort(temp_hand, function(a, b)
            return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
        end)
        pseudoshuffle(temp_hand, "c_chm_scythe")
        for i = 1, math.floor(lenient_bignum(G.GAME.dollars / card.ability.extra.dollars)) do
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
        delay(0.5)
    end
}

SMODS.Consumable {
    key = "whip",
    name = "Whip",
    set = "Lenormand",
    pos = { x = 3, y = 3 },
    config = {
        extra = {
            destroy_count = 2,
            max_highlighted = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.destroy_count,
                card.ability.extra.max_highlighted
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted 
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    SMODS.destroy_cards(G.hand.highlighted)
                    return true
                end
            }))
            delay(0.3)
            local destroyed_cards = {}
            local temp_hand = {}
            for _, playing_card in ipairs(G.hand.cards) do
                temp_hand[#temp_hand + 1] = playing_card
            end
            table.sort(temp_hand, function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end)
            pseudoshuffle(temp_hand, "c_chm_whip")
            for i = 1, card.ability.extra.destroy_count do
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
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "birds",
    name = "Birds",
    set = "Lenormand",
    pos = { x = 2, y = 0 },
    config = {
        extra = {
            max_highlighted = 2
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_edition({ foil = true }, true)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "child",
    name = "Child",
    set = "Lenormand",
    pos = { x = 4, y = 0 },
    config = { extra = { max_highlighted = 2 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_doodle
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_chm_doodle"])            
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "fox",
    name = "Fox",
    set = "Lenormand",
    pos = { x = 2, y = 1 },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return (G.GAME.blind.in_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.GAME.blind.in_blind then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("timpani")
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        local new_joker = SMODS.add_card({
                            set = "Joker",
                            rarity = "Common"
                        })
                        if new_joker then
                        end
                        G.GAME.joker_buffer = 0
                    end
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("timpani")
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        local new_joker = SMODS.add_card({
                            set = "Joker",
                            rarity = "Uncommon"
                        })
                        if new_joker then
                        end
                        G.GAME.joker_buffer = 0
                    end
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("timpani")
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                        local new_joker = SMODS.add_card({
                            set = "Joker",
                            rarity = "Rare"
                        })
                        if new_joker then
                        end
                        G.GAME.joker_buffer = 0
                    end
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
        end
        if not (G.GAME.blind.in_blind) then
            for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        play_sound("timpani")
                        SMODS.add_card({
                            set = "Lenormand",
                            key = "c_chm_ox"
                        })
                        used_card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
            delay(0.6)
            return true
        end
    end
}

SMODS.Consumable {
    key = "bear",
    name = "Bear",
    set = "Lenormand",
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            losedollars = 20,
            fordollars = 25
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.losedollars,
                card.ability.extra.fordollars
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        if to_number(G.GAME.dollars) >= card.ability.extra.fordollars then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    ease_dollars(-(math.floor(to_number(G.GAME.dollars) / card.ability.extra.fordollars) * card.ability.extra.losedollars), true)
                    return true
                end
            }))
            delay(0.6)
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                card:juice_up(0.3, 0.5)
                play_sound("timpani")
                ease_dollars((lenient_bignum(G.GAME.dollars * 3)), true)
                return true
            end
        }))
        delay(0.6)
    end
}

SMODS.Consumable {
    key = "stars",
    name = "Stars",
    set = "Lenormand",
    pos = {x = 8, y = 2},
    config = { extra = { levels = 1 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card) 
        return {
            vars = {
                card.ability.extra.levels,
                G.GAME.skips or 0
            }
        }
    end,
    can_use = function(self, card) 
        return G.GAME.skips ~= 0
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        local target_hand
        local available_hands = {}
        for hand, value in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(hand) then
                table.insert(available_hands, hand)
            end
        end
        target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed("c_chm_stars")) or "High Card"
        SMODS.calculate_effect({
            level_up = card.ability.extra.levels * G.GAME.skips,
            level_up_hand = target_hand 
        }, used_card)
    end
}

SMODS.Consumable {
    key = "stork",
    name = "Stork",
    set = "Lenormand",
    pos = { x = 9, y = 2 },
    config = { extra = { consumablesheld = 0 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = { ((#(G.consumeables and G.consumeables.cards or {}) or 0)) * 2 }
        }
    end,
    can_use = function(self, card)
        return G.hand
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, (#(G.consumeables and G.consumeables.cards or {})) * 2 do
                    local _rank = pseudorandom_element(SMODS.Ranks, "add_random_rank").card_key
                    local _suit = nil
                    local enhancement_pool = {}
                    for _, enhancement in pairs(G.P_CENTER_POOLS.Enhanced) do
                        if not enhancement.overrides_base_rank then
                            enhancement_pool[#enhancement_pool + 1] = enhancement
                        end
                    end
                    local enhancement = pseudorandom_element(enhancement_pool, "c_chm_stork")
                    local new_card_params = {
                        set = "Base"
                    }
                    if _rank then
                        new_card_params.rank = _rank
                    end
                    if _suit then
                        new_card_params.suit = _suit
                    end
                    if enhancement then
                        new_card_params.enhancement = enhancement.key
                    end
                    cards[i] = SMODS.add_card(new_card_params)
                end
                return {
                    playing_card_added = true,
                    cards = cards
                }
            end
        }))
        delay(0.3)
    end,
}

SMODS.Consumable {
    key = "dog",
    name = "Dog",
    set = "Lenormand",
    pos = { x = 9, y = 0 },
    config = { extra = { max_highlighted = 1 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.max_highlighted }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("tarot1")
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound("card1", percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    local min_id = 15
                    for _, c in ipairs(G.hand and G.hand.cards or {}) do
                        if c.base and c.base.id and not SMODS.has_no_rank(c) and c.base.id < min_id then
                            min_id = c.base.id
                        end
                    end
                    G.hand.highlighted[i].ability.perma_h_mult = (G.hand.highlighted[i].ability.perma_h_mult or 0) + (min_id ~= 15 and min_id or 0)
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound("tarot2", percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end
}

SMODS.Consumable {
    key = "tower",
    name = "Tower",
    set = "Lenormand",
    pos = { x = 1, y = 3 },
    config = {
        extra = {
            perma_bonus_value = 2,
            max_highlighted = 4
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.max_highlighted,
                card.ability.extra.perma_bonus_value
            }
        }
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted <= card.ability.extra.max_highlighted and #G.hand.highlighted >= 1)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted <= card.ability.extra.max_highlighted and #G.hand.highlighted >= 1) then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i].ability.perma_mult = G.hand.highlighted[i].ability.perma_mult or 0
                        G.hand.highlighted[i].ability.perma_mult = G.hand.highlighted[i].ability.perma_mult + 2
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "garden",
    name = "Garden",
    set = "Lenormand",
    pos = { x = 3, y = 1 },
    config = { extra = { x_earn_value = 5 } },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_earn_value } }
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        local min_id = 15
        for _, c in ipairs(G.hand and G.hand.cards or {}) do
            if c.base and c.base.id and not SMODS.has_no_rank(c) and c.base.id < min_id then
                min_id = c.base.id
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                ease_dollars(min_id * card.ability.extra.x_earn_value, true)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end
}

SMODS.Consumable {
    key = "mountain",
    name = "Mountain",
    set = "Lenormand",
    pos = { x = 2, y = 2 },
    config = {
        extra = {
            booster_value = 1,
            hand_size_value = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.booster_value,
                G.GAME.mountain_minus or 1 
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                SMODS.change_booster_limit(card.ability.extra.booster_value)
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                G.GAME.mountain_minus = G.GAME.mountain_minus or 1
                G.hand:change_size(-G.GAME.mountain_minus)
                G.GAME.mountain_minus = G.GAME.mountain_minus + 1
                return true
            end
        }))
    end
}

SMODS.Consumable {
    key = "crossroads",
    name = "Crossroads",
    set = "Lenormand",
    pos = { x = 8, y = 0 },
    config = {
        extra = {
            max_highlighted = 1,
            odds = 2,
            copy_cards_amount = 3
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "c_chm_crossroads")
        return {
            vars = {
                card.ability.extra.max_highlighted,
                numerator,
                denominator,
                card.ability.extra.copy_cards_amount
            }
        }
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted == card.ability.extra.max_highlighted)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 1 then
            if SMODS.pseudorandom_probability(card, "c_chm_crossroads", 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        SMODS.destroy_cards(G.hand.highlighted)
                        return true
                    end
                }))
                delay(0.3)
            else
                G.E_MANAGER:add_event(Event({
                func = function()
                    local _first_materialize = nil
                    local new_cards = {}
                    for _, selected_card in pairs(G.hand.highlighted) do
                        for i = 1, card.ability.extra.copy_cards_amount do
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local copied_card = copy_card(selected_card, nil, nil, G.playing_card)
                            copied_card:add_to_deck()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            table.insert(G.playing_cards, copied_card)
                            G.hand:emplace(copied_card)
                            copied_card:start_materialize(nil, _first_materialize)
                            _first_materialize = true
                            new_cards[#new_cards + 1] = copied_card
                        end
                    end
                    return {
                        playing_card_added = true,
                        cards = new_cards
                    }
                end
            }))
            delay(0.6)
            end
        end
    end
}

SMODS.Consumable {
    key = "mice",
    set = "Lenormand",
    config = { extra = { max_highlighted = 2 } },
    pos = { x = 0, y = 2 },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_rotten
        return {
            vars = { 
                card.ability.extra.max_highlighted
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_chm_rotten"])
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "ring",
    name = "Ring",
    set = "Lenormand",
    pos = { x = 4, y = 2 },
    config = { extra = { copy = 1, max_highlighted = 2 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = { 
                card.ability.extra.copy,
                card.ability.extra.max_highlighted
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _first_materialize = nil
                    local new_cards = {}
                    for _, selected_card in pairs(G.hand.highlighted) do
                        for i = 1, card.ability.extra.copy do
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local copied_card = copy_card(selected_card, nil, nil, G.playing_card)
                            copied_card:add_to_deck()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            table.insert(G.playing_cards, copied_card)
                            G.hand:emplace(copied_card)
                            copied_card:start_materialize(nil, _first_materialize)
                            _first_materialize = true
                            new_cards[#new_cards + 1] = copied_card
                        end
                    end
                    SMODS.calculate_context({
                        playing_card_added = true,
                        cards = new_cards
                    })
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS.c_base)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "book",
    name = "Book",
    config = { extra = { max_highlighted = 1 } },
    set = "Lenormand",
    pos = { x = 3, y = 0 },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_literature
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_chm_literature"])            
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "letter",
    name = "Letter",
    config = { extra = { max_highlighted = 3 } },
    set = "Lenormand",
    pos = { x = 7, y = 1 },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS.c_base)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        local seal_pool = {"Gold", "Red", "Blue", "Purple"}
                        local random_seal = pseudorandom_element(seal_pool, "random_seal")
                        G.hand.highlighted[i]:set_seal(random_seal, nil, true)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_edition(nil, true)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "man",
    name = "Man",
    config = { extra = { max_highlighted = 3 } },
    set = "Lenormand",
    pos = { x = 9, y = 1 },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        local enhancement_pool = {}
                        for _, enhancement in pairs(G.P_CENTER_POOLS.Enhanced) do
                            if not enhancement.overrides_base_rank then
                                enhancement_pool[#enhancement_pool + 1] = enhancement
                            end
                        end
                        local enhancement = pseudorandom_element(enhancement_pool, "random_enhance")
                        G.hand.highlighted[i]:set_ability(enhancement)
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "lady",
    name = "Lady",
    config = { extra = { max_highlighted = 4 } },
    set = "Lenormand",
    pos = { x = 6, y = 1 },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        local _rank = pseudorandom_element(SMODS.Ranks, "random_rank")
                        assert(SMODS.change_base(G.hand.highlighted[i], nil, _rank.key))
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "lily",
    name = "Lily",
    set = "Lenormand",
    pos = { x = 8, y = 1 },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return true
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_coupon
        info_queue[#info_queue + 1] = G.P_TAGS.tag_d_six
        return { vars = {  } }
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_coupon")
                tag:set_ability()
                add_tag(tag)
                play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_d_six")
                tag:set_ability()
                add_tag(tag)
                play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end
}

SMODS.Consumable {
    key = "sun",
    name = "Sun",
    set = "Lenormand",
    pos = { x = 0, y = 3 },
    config = {
        extra = {
            highlight1 = 1,
            highlight2 = 2,
            highlight3 = 3
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.highlight1,
                card.ability.extra.highlight2,
                card.ability.extra.highlight3
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and ((#G.hand.highlighted == card.ability.extra.highlight1) or (#G.hand.highlighted == card.ability.extra.highlight2) or (#G.hand.highlighted == card.ability.extra.highlight3))
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == card.ability.extra.highlight1 then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        assert(SMODS.change_base(G.hand.highlighted[i], nil, "Ace"))
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
        if #G.hand.highlighted == card.ability.extra.highlight2 then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        assert(SMODS.change_base(G.hand.highlighted[i], nil, "2"))
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
        if #G.hand.highlighted == card.ability.extra.highlight3 then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        assert(SMODS.change_base(G.hand.highlighted[i], nil, "3"))
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "moon",
    name = "Moon",
    set = "Lenormand",
    pos = { x = 1, y = 2 },
    config = { extra = { max_highlighted = 2 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_old
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_chm_old"])
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "key",
    name = "Key",
    set = "Lenormand",
    pos = { x = 5, y = 1 },
    config = { extra = { max_highlighted = 1 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_mechanical
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_chm_mechanical"])
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

local function foilcardsindeck()
    local count = 0
    for _, card in ipairs(G.playing_cards or {}) do
        if card.edition and card.edition.foil then
            count = count + 1 
        end
    end
    return count
end

local function holographiccardsindeck()
    local count = 0
    for _, card in ipairs(G.playing_cards or {}) do
        if card.edition and card.edition.holo then
            count = count + 1 
        end
    end
    return count
end

local function polychromecardsindeck()
    local count = 0
    for _, card in ipairs(G.playing_cards or {}) do
        if card.edition and card.edition.polychrome then
            count = count + 1 
        end
    end
    return count
end

SMODS.Consumable {
    key = "fish",
    name = "Fish",
    set = "Lenormand",
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            foildollars = 1,
            holographicdollars = 2,
            polychromedollars = 3,
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.foildollars,
                card.ability.extra.holographicdollars,
                card.ability.extra.polychromedollars,
                foilcardsindeck() * card.ability.extra.foildollars,
                holographiccardsindeck() * card.ability.extra.holographicdollars,
                polychromecardsindeck() * card.ability.extra.polychromedollars,
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        local affected_card = nil
        if G.hand and #G.hand.cards > 0 then
            affected_card = pseudorandom_element(G.hand.cards, pseudoseed("c_chm_fish"))
        end
        local affected_cards = affected_card and {affected_card} or {}
        local original_foil_count = foilcardsindeck()
        local original_holo_count = holographiccardsindeck()
        local original_poly_count = polychromecardsindeck()
        local added_editions = { foil = false, holo = false, polychrome = false }
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #affected_cards do
            local percent = 1.15 - (i - 0.999) / (#affected_cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    affected_cards[i]:flip()
                    play_sound("card1", percent)
                    affected_cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #affected_cards do
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    local edition_type = pseudorandom_element({ "foil", "holo", "polychrome" }, pseudoseed("c_chm_fish"))
                    local edition = {[edition_type] = true}
                    affected_cards[i]:set_edition(edition, true)
                    added_editions[edition_type] = true
                    if edition_type == "foil" and original_foil_count == 0 then
                        original_foil_count = 1
                    elseif edition_type == "holo" and original_holo_count == 0 then
                        original_holo_count = 1
                    elseif edition_type == "polychrome" and original_poly_count == 0 then
                        original_poly_count = 1
                    end
                    return true
                end
            }))
        end
        for i = 1, #affected_cards do
            local percent = 0.85 + (i - 0.999) / (#affected_cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    affected_cards[i]:flip()
                    play_sound("tarot2", percent, 0.6)
                    affected_cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                local foil_count = foilcardsindeck()
                local holo_count = holographiccardsindeck()
                local poly_count = polychromecardsindeck()
                if (added_editions["foil"] or original_foil_count > 0) and foil_count > 0 then
                    card:juice_up(0.3, 0.5)
                    ease_dollars(foil_count * card.ability.extra.foildollars, true)
                    delay(0.3)
                end
                if (added_editions["holo"] or original_holo_count > 0) and holo_count > 0 then
                    card:juice_up(0.3, 0.5)
                    ease_dollars(holo_count * card.ability.extra.holographicdollars, true)
                    delay(0.3)
                end
                if (added_editions["polychrome"] or original_poly_count > 0) and poly_count > 0 then
                    card:juice_up(0.3, 0.5)
                    ease_dollars(poly_count * card.ability.extra.polychromedollars, true)
                    delay(0.3)
                end
                return true
            end
        }))
    end
}

SMODS.Consumable {
    key = "key",
    name = "Key",
    set = "Lenormand",
    pos = { x = 5, y = 1 },
    config = { extra = { max_highlighted = 1 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_mechanical
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_chm_mechanical"])
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

local function foilcardsindeck()
    local count = 0
    for _, card in ipairs(G.playing_cards or {}) do
        if card.edition and card.edition.foil then
            count = count + 1 
        end
    end
    return count
end

local function holographiccardsindeck()
    local count = 0
    for _, card in ipairs(G.playing_cards or {}) do
        if card.edition and card.edition.holo then
            count = count + 1 
        end
    end
    return count
end

local function polychromecardsindeck()
    local count = 0
    for _, card in ipairs(G.playing_cards or {}) do
        if card.edition and card.edition.polychrome then
            count = count + 1 
        end
    end
    return count
end

SMODS.Consumable {
    key = "anchor",
    name = "Anchor",
    set = "Lenormand",
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            max_highlighted = 2
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_ricochet
        return { vars = { card.ability.extra.max_highlighted } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("card1", percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_chm_ricochet"])            
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound("tarot2", percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

SMODS.Consumable {
    key = "cross",
    name = "Cross",
    set = "Lenormand",
    pos = { x = 7, y = 0 },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("timpani")
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local new_joker = SMODS.add_card({ set = "Joker", rarity = "Uncommon" })
                    if new_joker then
                    end
                        G.GAME.joker_buffer = 0
                    end
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("timpani")
                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local new_joker = SMODS.add_card({ set = "Joker", rarity = "Common" })
                    if new_joker then
                    end
                        G.GAME.joker_buffer = 0
                    end
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
    end
}