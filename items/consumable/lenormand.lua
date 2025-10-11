SMODS.Consumable {
    key = "rider",
    name = "Rider",
    set = "Lenormand",
    pos = { x = 3, y = 2 },
    config = { extra = { tags = 2, dollars = 35 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.tag_investment
        return { vars = { card.ability.extra.tags, card.ability.extra.dollars } }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        for i = 1, card.ability.extra.tags do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local tag = Tag("tag_speed")
                    if tag.name == "Orbital Tag" then
                        local _poker_hands = {}
                        for k, v in pairs(G.GAME.hands) do
                            if v.visible then
                                _poker_hands[#_poker_hands + 1] = k
                            end
                        end
                        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                    end
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
                card_eval_status_text(used_card, "extra", nil, nil, nil, {
                    message = "-$" .. tostring(card.ability.extra.dollars),
                    colour = G.C.RED
                })
                ease_dollars(-math.min(G.GAME.dollars, card.ability.extra.dollars), true)
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
        return { vars = { (G.hand.config.card_limit or 8) } }
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
        return { vars = { card.ability.extra.perma_bonus_value } }
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
                        G.hand.highlighted[i].ability.h_chips = G.hand.highlighted[i].ability.h_chips or 0
                        G.hand.highlighted[i].ability.h_chips = G.hand.highlighted[i].ability.h_chips + card.ability.extra.perma_bonus_value
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
                (G.playing_cards and (G.GAME.starting_deck_size - #G.playing_cards) or 0) * card.ability.extra.dollars
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
                ease_dollars((G.playing_cards and (G.GAME.starting_deck_size - #G.playing_cards) or 0) * card.ability.extra.dollars, true)
                return true
            end
        }))
        delay(0.6)
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
        return {
            vars = {
                card.ability.extra.destroy,
                card.ability.extra.edition
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local destructable_jokers = {}
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and
                not G.jokers.cards[i].getting_sliced then
                destructable_jokers[#destructable_jokers + 1] = G.jokers.cards[i]
            end
        end
        local joker_to_destroy = pseudorandom_element(destructable_jokers, "c_chm_flowers")
        if joker_to_destroy then
            for i = 1, card.ability.extra.destroy do
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
        local used_card = copier or card
        local jokers_to_edition = {}
        local eligible_jokers = {}
        if "editionless" == "editionless" then
            eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        else
            for _, joker in pairs(G.jokers.cards) do
                if joker.ability.set == "Joker" then
                    eligible_jokers[#eligible_jokers + 1] = joker
                end
            end
        end
        if #eligible_jokers > 0 then
            local temp_jokers = {}
            for _, joker in ipairs(eligible_jokers) do
                temp_jokers[#temp_jokers + 1] = joker
            end
            pseudoshuffle(temp_jokers, 76543)
            for i = 1, math.min(card.ability.extra.edition, #temp_jokers) do
                jokers_to_edition[#jokers_to_edition + 1] = temp_jokers[i]
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for _, joker in pairs(jokers_to_edition) do
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    joker:set_edition({
                        holo = true
                    }, true)
                    return true
                end
            }))
        end
        delay(0.6)
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
            destroy_count = 2
        }
    },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return (#G.hand.highlighted == 1)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 1 then
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
            for i = 1, 2 do
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
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return ((#G.hand.highlighted == 1 or #G.hand.highlighted == 2))
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted == 1 or #G.hand.highlighted == 2) then
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
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_doodle
        return { vars = {  } }
    end,
    can_use = function(self, card)
        return ((#G.hand.highlighted <= 2 and #G.hand.highlighted >= 1))
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted <= 2 and #G.hand.highlighted >= 1) then
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
        return (G.GAME.blind.in_blind) or (not (G.GAME.blind.in_blind))
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
    config = { extra = { dollars = 20 } },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        if to_number(G.GAME.dollars) >= 25 then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    ease_dollars(-(math.floor(to_number(G.GAME.dollars) / 25) * card.ability.extra.dollars), true)
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
    pos = { x = 8, y = 2 },
    config = {
        extra = {
            blindsskipped = 0,
            levels = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {(G.GAME.skips or 0)}
        }
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted == 100)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        for i = 1, G.GAME.skips do
            update_hand_text({
                sound = "button",
                volume = 0.7,
                pitch = 0.8,
                delay = 0.3
            }, {
                handname = "???",
                chips = "???",
                mult = "???",
                level = ""
            })
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    play_sound("tarot1")
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({
                delay = 0
            }, {
                mult = "+",
                StatusText = true
            })
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.9,
                func = function()
                    play_sound("tarot1")
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({
                delay = 0
            }, {
                chips = "+",
                StatusText = true
            })
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.9,
                func = function()
                    play_sound("tarot1")
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({
                sound = "button",
                volume = 0.7,
                pitch = 0.9,
                delay = 0
            }, {
                level = "+" .. tostring(1)
            })
            delay(1.3)
            local hand_pool = {}
            for hand_key, _ in pairs(G.GAME.hands) do
                table.insert(hand_pool, hand_key)
            end
            local random_hand = pseudorandom_element(hand_pool, "random_hand_levelup")
            level_up_hand(card, random_hand, true, 1)
            update_hand_text({
                sound = "button",
                volume = 0.7,
                pitch = 1.1,
                delay = 0
            }, {
                handname = localize(random_hand, "poker_hands"),
                chips = G.GAME.hands[random_hand].chips,
                mult = G.GAME.hands[random_hand].mult,
                level = G.GAME.hands[random_hand].level
            })
            delay(1.3)
        end
        if #G.hand.highlighted == 100 then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, "extra", nil, nil, nil, {
                        message = "+" .. tostring(G.GAME.skips) .. " $",
                        colour = G.C.MONEY
                    })
                    ease_dollars(G.GAME.skips, true)
                    return true
                end
            }))
            delay(0.6)
        end
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
            vars = {((#(G.consumeables and G.consumeables.cards or {}) or 0)) * 2}
        }
    end,
    can_use = function(self, card)
        return true
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
                    local cen_pool = {}
                    for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if enhancement_center.key ~= "m_stone" and not enhancement_center.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = enhancement_center
                        end
                    end
                    local enhancement = pseudorandom_element(cen_pool, "add_cards_enhancement")
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
                SMODS.calculate_context({
                    playing_card_added = true,
                    cards = cards
                })
                return true
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
    config = { extra = { lowestrankinhand = 0 } },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return true
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
                        G.hand.highlighted[i].ability.h_mult = G.hand.highlighted[i].ability.h_mult or 0
                        G.hand.highlighted[i].ability.h_mult = G.hand.highlighted[i].ability.h_mult + (function() local min = 14; for _, card in ipairs(G.hand and G.hand.cards or {}) do if card.base.id < min then min = card.base.id end end; return min end)()
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
    config = { extra = { perma_bonus_value = 2 } },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return ((#G.hand.highlighted <= 4 and #G.hand.highlighted >= 1))
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted <= 4 and #G.hand.highlighted >= 1) then
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
    config = { extra = { lowestrankinhand = 0 } },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                card_eval_status_text(used_card, "extra", nil, nil, nil, {
                    message = "+" .. tostring(((function()
                        local min = 14;
                        for _, card in ipairs(G.hand and G.hand.cards or {}) do
                            if card.base.id < min then
                                min = card.base.id
                            end
                        end
                        return min
                    end)()) * 5) .. " $",
                    colour = G.C.MONEY
                })
                ease_dollars(((function()
                    local min = 14;
                    for _, card in ipairs(G.hand and G.hand.cards or {}) do
                        if card.base.id < min then
                            min = card.base.id
                        end
                    end
                    return min
                end)()) * 5, true)
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
            booster_slots_value = 1,
            voucher_slots_value = 1,
            hand_size_value = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                card_eval_status_text(used_card, "extra", nil, nil, nil, {
                    message = "+" .. tostring(1) .. " Booster Slots",
                    colour = G.C.BLUE
                })
                SMODS.change_booster_limit(1)
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                card_eval_status_text(used_card, "extra", nil, nil, nil, {
                    message = "+" .. tostring(1) .. " Voucher Slots",
                    colour = G.C.BLUE
                })
                SMODS.change_voucher_limit(1)
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                card_eval_status_text(used_card, "extra", nil, nil, nil, {
                    message = "-" .. tostring(1) .. " Hand Size",
                    colour = G.C.RED
                })
                G.hand:change_size(-1)
                return true
            end
        }))
        delay(0.6)
    end
}

SMODS.Consumable {
    key = "crossroads",
    name = "Crossroads",
    set = "Lenormand",
    pos = { x = 8, y = 0 },
    config = {
        extra = {
            odds = 2,
            copy_cards_amount = 3
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "c_chmcrossroads")
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted == 1)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 1 then
            if SMODS.pseudorandom_probability(card, "c_chmcrossroads", 1, card.ability.extra.odds) then
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
            end
            if SMODS.pseudorandom_probability(card, "c_chmcrossroads", 1, card.ability.extra.odds) then
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
                    
                    SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                    return true
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
    pos = { x = 0, y = 2 },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return ((#G.hand.highlighted <= 2 and #G.hand.highlighted >= 1))
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted <= 2 and #G.hand.highlighted >= 1) then
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
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_chm_otten"])
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
    config = { extra = { copy_cards_amount = 1 } },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return ((#G.hand.highlighted <= 2 and #G.hand.highlighted >= 1))
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted <= 2 and #G.hand.highlighted >= 1) then
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
    set = "Lenormand",
    pos = { x = 3, y = 0 },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_literature
        return { vars = {  } }
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted == 1)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 1 then
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
    set = "Lenormand",
    pos = { x = 7, y = 1 },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return (#G.hand.highlighted <= 2)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted <= 2 then
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
    set = "Lenormand",
    pos = { x = 9, y = 1 },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return ((#G.hand.highlighted >= 1 or #G.hand.highlighted <= 3))
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted >= 1 or #G.hand.highlighted <= 3) then
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
                        local cen_pool = {}
                        for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                            if enhancement_center.key ~= "m_stone" then
                                cen_pool[#cen_pool + 1] = enhancement_center
                            end
                        end
                        local enhancement = pseudorandom_element(cen_pool, "random_enhance")
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
    set = "Lenormand",
    pos = { x = 6, y = 1 },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return ((#G.hand.highlighted <= 4 and #G.hand.highlighted >= 1))
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted <= 4 and #G.hand.highlighted >= 1) then
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
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_d_six")
                if tag.name == "Orbital Tag" then
                    local _poker_hands = {}
                    for k, v in pairs(G.GAME.hands) do
                        if v.visible then
                            _poker_hands[#_poker_hands + 1] = k
                        end
                    end
                    tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                end
                tag:set_ability()
                add_tag(tag)
                play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_coupon")
                if tag.name == "Orbital Tag" then
                    local _poker_hands = {}
                    for k, v in pairs(G.GAME.hands) do
                        if v.visible then
                            _poker_hands[#_poker_hands + 1] = k
                        end
                    end
                    tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                end
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
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return (#G.hand.highlighted == 1) or (#G.hand.highlighted == 2) or (#G.hand.highlighted == 3)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 1 then
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
        if #G.hand.highlighted == 2 then
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
        if #G.hand.highlighted == 3 then
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
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_old
        return { vars = {  } }
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted <= 2)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted <= 2 then
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
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_key
        return { vars = {  } }
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted == 1)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 1 then
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
                        local cen_pool = {}
                        for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                            if enhancement_center.key ~= "m_stone" then
                                cen_pool[#cen_pool + 1] = enhancement_center
                            end
                        end
                        local enhancement = pseudorandom_element(cen_pool, "random_enhance")
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
    key = "fish",
    name = "Fish",
    set = "Lenormand",
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            foilcardsindeck = 0,
            holographiccardsindeck = 0,
            polychromecardsindeck = 0,
            cards_amount = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {vars = {((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if card.edition and card.edition.foil then count = count + 1 end end; return count end)()) * 3, ((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if card.edition and card.edition.holo then count = count + 1 end end; return count end)()) * 5, ((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if card.edition and card.edition.polychrome then count = count + 1 end end; return count end)()) * 7}}
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local affected_cards = {}
        local temp_hand = {}
        for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )
        pseudoshuffle(temp_hand, "c_chm_fish")
        for i = 1, math.min(card.ability.extra.cards_amount, #temp_hand) do 
            affected_cards[#affected_cards + 1] = temp_hand[i] 
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
                    local edition = poll_edition("random_edition", nil, true, true, { "e_polychrome", "e_holo", "e_foil" })
                    affected_cards[i]:set_edition(edition, true)
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
        if
            function()
                for _, card in ipairs(G.playing_cards or {}) do
                    if card.edition and card.edition.foil then
                        return true
                    end
                end
                return false
            end
        then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                card:juice_up(0.3, 0.5)
                ease_dollars(
                    function()
                        local count = 0
                        for _, card in ipairs(G.playing_cards or {}) do
                            if card.edition and card.edition.foil then
                                count = count + 1
                            end
                        end
                        return count * 3
                    end, true)
                return true
            end
        }))
        delay(0.6)
        end
        if
            function()
                for _, card in ipairs(G.playing_cards or {}) do
                    if card.edition and card.edition.holo then
                        return true
                    end
                end
                return false
            end
        then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                card:juice_up(0.3, 0.5)
                ease_dollars(
                    function()
                        local count = 0
                        for _, card in ipairs(G.playing_cards or {}) do
                            if card.edition and card.edition.holo then
                                count = count + 1
                            end
                        end
                        return count * 5
                    end, true)
                return true
            end
        }))
        delay(0.6)
        end
        if
            function()
                for _, card in ipairs(G.playing_cards or {}) do
                    if card.edition and card.edition.polychrome then
                        return true
                    end
                end
                return false
            end
        then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                card:juice_up(0.3, 0.5)
                ease_dollars(
                    function()
                        local count = 0
                        for _, card in ipairs(G.playing_cards or {}) do
                            if card.edition and card.edition.polychrome then
                                count = count + 1
                            end
                        end
                        return count * 7
                    end, true)
                return true
            end
        }))
        delay(0.6)
        end
    end
}

SMODS.Consumable {
    key = "anchor",
    name = "Anchor",
    set = "Lenormand",
    pos = { x = 0, y = 0 },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_polished
        return { vars = {  } }
    end,
    can_use = function(self, card)
        return ((#G.hand.highlighted <= 2 and #G.hand.highlighted >= 1))
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if (#G.hand.highlighted <= 2 and #G.hand.highlighted >= 1) then
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
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS["m_chm_polished"])            
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
        return true
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