SMODS.Consumable {
    key = "anchor",
    name = "Anchor",
    set = "Lenormand",
    pos = { x = 0, y = 0 },
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
    key = "bear",
    name = "Bear",
    set = "Lenormand",
    pos = { x = 1, y = 0 },
    config = { extra = { dollars_value = 40, double_limit = 100000000000 } },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
            for i = 1, math.floor(lenient_bignum(G.GAME.dollars / 50)) do
                G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, "extra", nil, nil, nil, {message = "-"..tostring(40).." $", colour = G.C.RED})
                    ease_dollars(-math.min(G.GAME.dollars, 40), true)
                    return true
                end
            }))
            delay(0.6)
          end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("timpani")
                    used_card:juice_up(0.3, 0.5)
                    local double_amount = math.min(G.GAME.dollars, 100000000000)
                    ease_dollars(double_amount, true)
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("timpani")
                    used_card:juice_up(0.3, 0.5)
                    local double_amount = math.min(G.GAME.dollars, 20000000000)
                    ease_dollars(double_amount, true)
                    return true
                end
            }))
            delay(0.6)
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
    key = "book",
    name = "Book",
    set = "Lenormand",
    pos = { x = 3, y = 0 },
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
    key = "child",
    name = "Child",
    set = "Lenormand",
    pos = { x = 4, y = 0 },
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
    key = "clover",
    name = "Clover",
    set = "Lenormand",
    pos = { x = 5, y = 0 },
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
    key = "coffin",
    name = "Coffin",
    set = "Lenormand",
    pos = { x = 6, y = 0 },
    config = { extra = { destroy_count = 3, add_cards_count = 2 } },
    cost = 3,
    atlas = "consumable",
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
                    for i = 1, 2 do
                        local _rank = pseudorandom_element(SMODS.Ranks, "add_random_rank").card_key
                        local _suit = nil
                        local new_card_params = { set = "Base" }
                        if _rank then new_card_params.rank = _rank end
                        if _suit then new_card_params.suit = _suit end
                        cards[i] = SMODS.add_card(new_card_params)
                        if cards[i] then
                            local edition = poll_edition("add_cards_edition", nil, true, true, 
                                { "e_polychrome", "e_holo", "e_foil" })
                            cards[i]:set_edition(edition, true)
                        end
                    end
                    SMODS.calculate_context({ playing_card_added = true, cards = cards })
                    return true
                end
            }))
            delay(0.3)
            local destroyed_cards = {}
            local temp_hand = {}

            for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
            table.sort(temp_hand,
                function(a, b)
                    return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
                end
            )

            pseudoshuffle(temp_hand, 12345)

            for i = 1, 3 do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

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

SMODS.Consumable {
    key = "crossroads",
    set = "Lenormand",
    pos = { x = 8, y = 0 },
    config = { extra = { odds = 2, copy_cards_amount = 3 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "c_chmcrossroads")
        return { vars = { numerator, denominator } }
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted == 1)
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 1 then
            if SMODS.pseudorandom_probability(card, "group_0_f6bf59f6", 1, card.ability.extra.odds, "c_chmcrossroads", false) then
                
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
            if SMODS.pseudorandom_probability(card, "group_1_9857b26b", 1, card.ability.extra.odds, "c_chmcrossroads", false) then
                
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
    key = "dog",
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
    key = "fish",
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
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, "extra", nil, nil, nil, {message = "+"..tostring(((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if card.edition and card.edition.foil then count = count + 1 end end; return count end)()) * 3).." $", colour = G.C.MONEY})
                    ease_dollars(((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if card.edition and card.edition.foil then count = count + 1 end end; return count end)()) * 3, true)
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, "extra", nil, nil, nil, {message = "+"..tostring(((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if card.edition and card.edition.holo then count = count + 1 end end; return count end)()) * 5).." $", colour = G.C.MONEY})
                    ease_dollars(((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if card.edition and card.edition.holo then count = count + 1 end end; return count end)()) * 5, true)
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, "extra", nil, nil, nil, {message = "+"..tostring(((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if card.edition and card.edition.polychrome then count = count + 1 end end; return count end)()) * 7).." $", colour = G.C.MONEY})
                    ease_dollars(((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if card.edition and card.edition.polychrome then count = count + 1 end end; return count end)()) * 7, true)
                    return true
                end
            }))
            delay(0.6)
            local affected_cards = {}
            local temp_hand = {}

            for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
            table.sort(temp_hand,
                function(a, b)
                    return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
                end
            )

            pseudoshuffle(temp_hand, 12345)

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
                        local edition = poll_edition("random_edition", nil, true, true, 
                            { "e_polychrome", "e_holo", "e_foil" })
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
    end,
}