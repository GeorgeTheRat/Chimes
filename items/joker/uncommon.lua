SMODS.Joker{
    key = "alarm",
    name = "Alarm",
    config = { extra = { xmult = 1.5 } },
    pos = { x = 0, y = 0 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker{
    key = "batteries",
    name = "Batteries",
    config = { extra = { repetitions = 3 } },
    pos = { x = 1, y = 0 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card:get_id() == 14 and next(context.poker_hands["Three of a Kind"]) then
            return {
                repetitions = card.ability.extra.repetitions,
                message = localize("k_again_ex")
            }
        end
    end
}

SMODS.Joker{
    key = "brain",
    name = "Brain",
    config = {
        extra = {
            mult = 2,
            odds = 6,
            mult_mod = 1,
            mult_mod_mod = 1,
        }
    },
    pos = { x = 4, y = 0 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_brain")
        return { vars = {
            card.ability.extra.mult,
            numerator,
            denominator,
            card.ability.extra.mult_mod,
            card.ability.extra.mult_mod_mod
        }
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, "j_chm_brain", 1, card.ability.extra.odds) then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                card.ability.extra.mult_mod = card.ability.extra.mult_mod + card.ability.extra.mult_mod_mod
            end
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{
    key = "chocolate_strawberry",
    name = "Chocolate Strawberry",
    config = { extra = { joker_slots = 4, joker_slots_mod = 1, context = 1 } },
    pos = { x = 6, y = 0 },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.joker_slots, card.ability.extra.joker_slots_mod } }
    end,
    calculate = function(self, card, context)
        if ((G.GAME.blind:get_type() == "Small" or G.GAME.blind:get_type() == "Big" or G.GAME.blind.boss) and not context.blueprint) and card.ability.extra.context == 1 then
            G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots
            card.ability.extra.context = 0
        end
        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            if card.ability.extra.joker_slots >= 2 then
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
                card.ability.extra.joker_slots = card.ability.extra.joker_slots - card.ability.extra.joker_slots_mod
                card.ability.extra.context = 1
            end
            if card.ability.extra.joker_slots == 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true
                            end,
                        }))
                        return true
                    end,
                }))
                return {
                    message = localize("k_eaten"),
                    colour = G.C.FILTER,
                }
            end
        end
        if context.selling_self and not context.blueprint then
            if G.GAME.blind:get_type() == "Small" or G.GAME.blind:get_type() == "Big" or G.GAME.blind.boss then
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
                card.ability.extra.joker_slots = card.ability.extra.joker_slots - card.ability.extra.joker_slots_mod
            end
        end
    end
}

SMODS.Joker{
    key = "colored_pencils",
    name = "Colored Pencils",
    pos = { x = 7, y = 0 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (#context.full_hand == 1 and G.GAME.current_round.hands_left == 0) then
                context.other_card:set_edition("e_polychrome", true)
                return {
                    message = "Polychrome!",
                    colour = G.C.DARK_EDTION
                }
            end
        end
    end
}

SMODS.Joker{
    key = "crayons",
    name = "Crayons",
    pos = { x = 8, y = 0 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (#context.full_hand == 3 and G.GAME.current_round.hands_left == 0) then
                context.other_card:set_edition("e_foil", true)
                return {
                    message = "Foil!",
                    colour = G.C.DARK_EDITION
                }
            end
        end
    end
}

SMODS.Joker{
    key = "elites",
    name = "Elites",
    config = { extra = { create = 1 } },
    pos = { x = 9, y = 0 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.create } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind.boss and #G.jokers.cards < G.jokers.config.card_limit then
            for i = 1, card.ability.extra.create do
                SMODS.add_card({ set = "Joker", rarity = 3 })
            end
        end
    end
}

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
                return {
                    func = function()
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
                    end,
                    message = "Added Card!"
                }
            end
        end
    end
}

SMODS.Joker {
    key = "garlic",
    name = "Garlic",
    config = { extra = { gargle = 2.5 } },
    pos = { x = 2, y = 1 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gargle } }
    end,
    calculate = function(self, card, context)
        if context.before then
            if card.ability.extra.gargle > 1 then
                local count = 0
                for _, playing_card in pairs(context.full_hand or {}) do
                    if not next(SMODS.get_enhancements(playing_card)) then
                        count = count + 1
                    end
                end
                card.ability.extra.gargle = card.ability.extra.gargle - (count * 0.1)
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true
                            end,
                        }))
                        return true
                    end,
                }))
                return {
                    message = localize("k_eaten"),
                    colour = G.C.FILTER,
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.gargle
            }
        end
    end
}

SMODS.Joker {
    key = "ghost_costume",
    name = "Ghost Costume",
    config = {
        extra = {
            odds = 13,
            dollars = 10,
        }
    },
    pos = { x = 3, y = 1 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    pools = { ["chm_costumes"] = true },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_ghostcostume")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, "vremade_space", 1, card.ability.extra.odds) then
            local random_edition = poll_edition("edit_card_edition", nil, true, true)
            if random_edition then
                context.other_card:set_edition(random_edition, true)
            end
            return {
                message = "Card Modified!",
                colour = G.C.BLUE
            }
        end
        if context.selling_self and not context.blueprint then
            return {
                dollars = -card.ability.extra.dollars,
                extra = {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({
                                        set = "chm_costumes"
                                    })
                                    if joker_card then
                                        G.GAME.joker_buffer = 0
                                    end
                                    return true
                                end
                            }))
                        end
                        if created_joker then
                            return {
                                message = "+1 Joker",
                                colour = G.C.BLUE
                            }
                        end
                        return true
                    end
                }
            }
        end
    end
}

SMODS.Joker {
    key = "hand_roll",
    name = "Hand Roll",
    config = {
        extra = {
            plushands = 4,
            plusdollars = 4,
            plushands_mod = 1,
            plusdollars_mod = 1
        }
    },
    pos = { x = 5, y = 1 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.plushands, card.ability.extra.plusdollars, card.ability.extra.plushands_mod, card.ability.extra.plusdollars_mod }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.plushands
            return {
                message = "+" .. tostring(card.ability.extra.plushands),
                colour = G.C.BLUE
            }
        end
        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            return {
                dollars = G.GAME.current_round.hands_left * card.ability.extra.plusdollars,
                extra = {
                    func = function()
                        if card.ability.extra.plushands > 1 or card.ability.extra.plusdollars > 1 then
                            card.ability.extra.plushands = math.max(0, (card.ability.extra.plushands) - 1)
                            card.ability.extra.plusdollars = math.max(0, (card.ability.extra.plusdollars) - 1)
                            return true
                        else
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound("tarot1")
                                    card.T.r = -0.2
                                    card:juice_up(0.3, 0.4)
                                    card.states.drag.is = true
                                    card.children.center.pinch.x = true
                                    G.E_MANAGER:add_event(Event({
                                        trigger = "after",
                                        delay = 0.3,
                                        blockable = false,
                                        func = function()
                                            G.jokers:remove_card(card)
                                            card:remove()
                                            card = nil
                                            return true
                                        end,
                                    }))
                                    return true
                                end,
                            }))
                        end
                    end,
                    message = "-" .. tostring(card.ability.extra.plushands_mod),
                    colour = G.C.RED,
                    extra = {
                        message = "-$" .. tostring(card.ability.extra.plusdollars_mod),
                        colour = G.C.RED
                    }
                }
            }
        end
    end
}
--[[
SMODS.Joker{
    key = "maki_roll",
    name = "Maki Roll",
    config = {
        extra = {
            
        }
    },
    pos = { x = 8, y = 1 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    pools = { ["chm_sushi"] = true },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
    end
}
--]]

SMODS.Joker {
    key = "monster_costume",
    name = "Monster Costume",
    config = {
        extra = {
            edititionion = 1,
            odds = 5,
            dollars = 10,
            costumes2 = 0,
            respect = 0
        }
    },
    pos = { x = 0, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    pools = { ["chm_costumes"] = true },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_chm_monstercostume')
        return {
            vars = {
                card.ability.extra.edititionion,
                card.ability.extra.costumes2,
                card.ability.extra.respect,
                numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, "j_chm_monstercostume", 1, card.ability.extra.odds) then
                local enhancement_pool = {}
                for _, enhancement in pairs(G.P_CENTER_POOLS.Enhanced) do
                    if enhancement.key ~= "m_stone" then
                        enhancement_pool[#enhancement_pool + 1] = enhancement
                    end
                end
                local random_enhancement = pseudorandom_element(enhancement_pool, "edit_card_enhancement")
                context.other_card:set_ability(random_enhancement)
                card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                    message = "Card Modified!",
                    colour = G.C.BLUE
                })
            end
        end
        if context.selling_self and not context.blueprint then
            return {
                dollars = -card.ability.extra.dollars,
                extra = {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({
                                        set = "chm_ostumes2"
                                    })
                                    if joker_card then
                                    end
                                    G.GAME.joker_buffer = 0
                                    return true
                                end
                            }))
                        end
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                                message = localize("k_plus_joker"),
                                colour = G.C.BLUE
                            })
                        end
                        return true
                    end,
                    colour = G.C.BLUE
                }
            }
        end
    end
}

SMODS.Joker {
    key = "motherboard",
    config = {
        extra = {
            chips = 0,
            chips_mod = 10,
            chips_mod_2 = 15
        }
    },
    pos = { x = 1, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_mod,
                card.ability.extra.chips_mod_2
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.pseudorandom_result then
            if context.result then
                card.ability.extra.chips = math.max(0, (card.ability.extra.chips) - card.ability.extra.chips_mod)
            else
                card.ability.extra.chips = (card.ability.extra.chips) - card.ability.extra.chips_mod_2
            end
        end
    end
}

SMODS.Joker {
    key = "onigiri",
    name = "Onigiri",
    config = {
        extra = {
            chips = 75,
            chips_mod = 15,
            voucher_slots = 1
        }
    },
    pos = { x = 2, y = 2 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_mod,
                card.ability.extra.voucher_slots
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = -card.ability.extra.chips
            }
        end
        if context.pre_discard and not context.blueprint then
            if card.ability.extra.chips <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true
                            end,
                        }))
                        return true
                    end,
                }))
                return {
                    message = localize("k_eaten"),
                    colour = G.C.FILTER,
                }
            else
                card.ability.extra.chips = math.max(0, (card.ability.extra.chips) - card.ability.extra.chips_mod)
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_voucher_limit(card.ability.extra.voucher_slots)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_voucher_limit(-card.ability.extra.voucher_slots)
    end
}

SMODS.Joker {
    key = "paper",
    config = {
        extra = {
            chips = 200,
            mult = -15
        }
    },
    pos = { x = 5, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                extra = {
                    mult = card.ability.extra.mult
                }
            }
        end
    end
}

SMODS.Joker {
    key = "polishedjoker",
    config = { extra = { discards = 1 } },
    pos = { x = 6, y = 2 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards } }
    end,
    calculate = function(self, card, context)
        if context.discard then
            if SMODS.get_enhancements(context.other_card)["m_chm_polished"] then
                G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + card.ability.extra.discards
                return {
                    message = "+" .. tostring(card.ability.extra.discards) .. " Discard",
                }
            end
        end
    end
}