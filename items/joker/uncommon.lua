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
    pos = { x = 9, y = 0 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind.boss then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_joker")
            card:add_to_deck()
            card:start_materialize()
            G.jokers:emplace(card)
        end
    end
}

SMODS.Joker {
    key = "fungi",
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