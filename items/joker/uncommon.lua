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

SMODS.Joker {
    key = "california_roll",
    name = "California Roll",
    config = {
        extra = {
            create = 5,
            decrease = 1
        }
    },
    pos = { x = 5, y = 0 },
    cost = 6,
    rarity = 2,
    eternal_compat = false,
    atlas = "joker",
    pools = { ["sushi"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.create,
                card.ability.extra.decrease
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            for i = 1, math.ceil(card.ability.extra.create) do
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if #G.jokers.cards < G.jokers.config.card_limit then
                                SMODS.add_card({ set = "Joker" })
                            end
                            G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                            return true
                        end
                    }))
                end
            end
            for i = 1, math.ceil(card.ability.extra.create) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            play_sound("timpani")
                            local forced_key = Chimes.random_consumable("california_roll", nil, "j_chm_california_roll")
                            local _card = create_card("Consumeables", G.consumeables, nil, nil, nil, nil, forced_key.config.center_key, "california_roll")
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                        end
                        return true
                    end,
                }))
            end
        end
        if context.playing_card_added then
            if card.ability.extra.create - card.ability.extra.decrease <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "create",
                    scalar_value = "create_mod",
                    operation = "-",
                    scaling_message = {
                        message = "-" .. tostring(card.ability.extra.create_mod)
                    }
                })
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local tag = Tag(pseudorandom_element(G.P_TAGS, pseudoseed("j_chm_california_roll")).key)
                        if tag.name == "Orbital Tag" then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then
                                    _poker_hands[#_poker_hands + 1] = k
                                end
                            end
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "j_chm_california_roll")
                        end
                        tag:set_ability()
                        add_tag(tag)
                        play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if #G.jokers.cards < G.jokers.config.card_limit then
                                SMODS.add_card({ set = "Joker" })
                            end
                            G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                            return true
                        end
                    }))
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            play_sound("timpani")
                            local forced_key = Chimes.random_consumable("california_roll", nil, "j_chm_california_roll")
                            local _card = create_card("Consumeables", G.consumeables, nil, nil, nil, nil, forced_key.config.center_key, "california_roll")
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                        end
                        return true
                    end,
                }))
            end
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
    blueprint_compat = false,
    eternal_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.joker_slots,
                card.ability.extra.joker_slots_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if (G.GAME.blind.in_blind and not context.blueprint) and card.ability.extra.context == 1 then
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
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end,
    remove_from_deck = function(self, card)
        if G.GAME.blind.in_blind then
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
            card.ability.extra.joker_slots = card.ability.extra.joker_slots - card.ability.extra.joker_slots_mod
        end
    end
}

SMODS.Joker{
    key = "colored_pencils",
    name = "Colored Pencils",
    config = { extra = { play_size = 1 } },
    pos = { x = 7, y = 0 },
    cost = 5,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        return { vars = { card.ability.extra.play_size } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (#context.full_hand == card.ability.extra.play_size and G.GAME.current_round.hands_left == 0) then
                context.other_card:set_edition("e_polychrome", true)
                return {
                    message = "Polychrome!",
                    colour = G.C.DARK_EDITION
                }
            end
        end
    end
}

SMODS.Joker{
    key = "crayons",
    name = "Crayons",
    config = { extra = { play_size = 3 } },
    pos = { x = 8, y = 0 },
    cost = 5,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        return { vars = { card.ability.extra.play_size } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (#context.full_hand == card.ability.extra.play_size and G.GAME.current_round.hands_left == 0) then
                context.other_card:set_edition("e_foil", true)
                return {
                    message = "Foil!",
                    colour = G.C.DARK_EDITION
                }
            end
        end
    end
}

SMODS.Joker {
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
                SMODS.add_card({
                    set = "Joker",
                    rarity = 3
                })
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

SMODS.Joker {
    key = "garlic",
    name = "Garlic",
    config = {
        extra = {
            xmult = 2.5,
            xmult_mod = 0.1
        }
    },
    pos = { x = 2, y = 1 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod } }
    end,
    calculate = function(self, card, context)
        if context.before then
            local count = 0
            for _, playing_card in pairs(context.scoring_hand or {}) do
                if not next(SMODS.get_enhancements(playing_card)) then
                    count = count + 1
                end
            end
            if card.ability.extra.xmult - (count * card.ability.extra.xmult_mod) > 1 then
                for i = 1, count do
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_value = "xmult_mod",
                        operation = "-",
                        no_message = true
                    })
                end
            else
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
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
            vars = {
                card.ability.extra.plushands,
                card.ability.extra.plusdollars,
                card.ability.extra.plushands_mod,
                card.ability.extra.plusdollars_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            SMODS.scale_card(card, {
                ref_table = G.GAME.current_round,
                ref_value = "hands_left",
                scalar_table = card.ability.extra,
                scalar_value = "plushands",
                scaling_message = {
                    message = "+" .. tostring(card.ability.extra.plushands) .. " Hand" .. (card.ability.extra.plushands > 1 and "s" or ""),
                    colour = G.C.BLUE
                }
            })
        end
        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            if (card.ability.extra.plushands - card.ability.extra.plushands_mod <= 0) or (card.ability.extra.plusdollars - card.ability.extra.plusdollars_mod <= 0) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "plushands",
                    scalar_value = "plushands_mod",
                    operation = "-",
                    scaling_message = {
                        message = "-" .. tostring(card.ability.extra.plushands_mod) .. " Hand" .. (card.ability.extra.plushands_mod > 1 and "s" or ""),
                        colour = G.C.BLUE
                    }
                })
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "plusdollars",
                    scalar_value = "plusdollars_mod",
                    operation = "-",
                    scaling_message = {
                        message = "-$" .. tostring(card.ability.extra.plusdollars_mod),
                        colour = G.C.MONEY
                    }
                })
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        return G.GAME.current_round.hands_left * card.ability.extra.plusdollars
    end
}

SMODS.Joker{
    key = "koi",
    name = "Koi",
    config = {
        extra = {
            perma_h_bonus = 2,
            perma_h_bonus_mod = 1
        }
    },
    pos = { x = 7, y = 1 },
    cost = 6,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return {
            vars = {
                card.ability.extra.perma_h_bonus,
                card.ability.extra.perma_h_bonus_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_h_bonus = (context.other_card.ability.perma_h_bonus or 0) + card.ability.extra.perma_h_bonus
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS
            }
        end
        if context.other_card and context.discard and SMODS.has_enhancement(context.other_card, "m_wild") then
            card.ability.perma_h_bonus = card.ability.perma_h_bonus + card.ability.extra.perma_h_bonus_mod
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS
            }
        end
    end
}

SMODS.Joker {
    key = "monster_costume",
    name = "Monster Costume",
    config = {
        extra = {
            odds = 5,
            dollars = 10,
        }
    },
    pos = { x = 0, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    pools = { ["costumes"] = true },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_monstercostume")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, "j_chm_monster_costume", 1, card.ability.extra.odds) then
                local enhancement_pool = {}
                for _, enhancement in pairs(G.P_CENTER_POOLS.Enhanced) do
                    if not enhancement.overrides_base_rank then
                        enhancement_pool[#enhancement_pool + 1] = enhancement
                    end
                end
                local random_enhancement = pseudorandom_element(enhancement_pool, "edit_card_enhancement")
                context.other_card:set_ability(random_enhancement)
                return {
                    message = "Card Modified!",
                    colour = G.C.BLUE,
                    card = context.other_card
                }
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
                                    local joker_card = SMODS.add_card({ set = "costumes" })
                                    if joker_card then
                                        G.GAME.joker_buffer = 0
                                    end
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
                }
            }
        end
    end
}

SMODS.Joker {
    key = "motherboard",
    config = {
        extra = {
            chips_mod = 10,
            chips_mod_2 = 15,
            chips = 0
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
                card.ability.extra.chips_mod,
                card.ability.extra.chips_mod_2,
                card.ability.extra.chips
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
                card.ability.extra.chips = (card.ability.extra.chips) + card.ability.extra.chips_mod_2
            end
        end
    end
}

SMODS.Joker {
    key = "rock",
    name = "Rock",
    config = {
        extra = {
            chips = -100,
            xmult = 3
        }
    },
    pos = { x = 9, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.xmult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                extra = {
                    xmult = card.ability.extra.xmult
                }
            }
        end
    end
}

SMODS.Joker {
    key = "paper",
    name = "Paper",
    config = {
        extra = {
            mult = -15,
            chips = 200
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
                card.ability.extra.mult,
                card.ability.extra.chips
            } 
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                extra = {
                    chips = card.ability.extra.chips
                }
            }
        end
    end
}

SMODS.Joker{
    key = "scissors",
    name = "Scissors",
    config = {
        extra = {
            xmult = 0.5,
            mult = 40
        }
    },
    pos = { x = 2, y = 3 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
                extra = {
                    mult = card.ability.extra.mult
                }
            }
        end
    end
}

SMODS.Joker {
    key = "wallbang",
    name = "Wallbang Joker",
    pos = { x = 6, y = 2 },
    cost = 5,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_ricochet
        return { vars = {  } }
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_chm_ricochet") then
                return true
            end
        end
        return false
    end
}

SMODS.Joker {
    key = "toycar",
    name = "Toy Car",
    config = {
        extra = {
            dollars = 1,
            dollars_mod = 1
        }
    },
    pos = { x = 9, y = 3 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.dollars_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_mod
            return {
                message = "Upgrade!",
                colour = G.C.MONEY
            }
        end
        if context.skip_blind then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}

SMODS.Joker {
    key = "waterfall",
    name = "Waterfall",
    config = { extra = { retriggers = 0 } },
    pos = { x = 3, y = 4 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.tag_negative
        return { vars = { card.ability.extra.retriggers } }
    end,
    calculate = function(self, card, context)
        if context.after and context.scoring_name == "Two Pair" then
            card.ability.extra.retriggers = card.ability.extra.retriggers + 1
            return {
                message = "Upgrade!",
                colour = G.C.ATTENTION
            }
        end
        if context.repetition then
            if (
                context.other_card:get_id() == 10 or
                context.other_card:get_id() == 9 or
                context.other_card:get_id() == 8 or
                context.other_card:get_id() == 7 or
                context.other_card:get_id() == 6
            ) then
                return {
                    repetitions = card.ability.extra.retriggers,
                    message = localize("k_again_ex")
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            card.ability.extra.retriggers = 0
            return {
                message = "Reset!",
                colour = G.C.ATTENTION
            }
        end
    end
}

SMODS.Joker {
    key = "wine",
    name = "Wine",
    config = { extra = { joker_slots = 1 } },
    pos = { x = 4, y = 4 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = false,
    discovered = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_negative
        return { vars = { card.ability.extra.joker_slots } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag("tag_negative"))
                    play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
            return nil, true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
    end,
    in_pool = function(self, args)
        return
            not args or
            (args.source ~= "buf" and
            args.source ~= "jud" and
            (args.source == "sho" or
            args.source == "rif" or
            args.source == "rta" or
            args.source == "sou" or
            args.source == "uta" or
            args.source == "wra"))
    end,
    check_for_unlock = function(self, args)
        if args.type == "modify_jokers" then
            local count = 0
            for _, joker in ipairs(G.jokers.cards) do
                count = count + 1
            end
            if count >= to_big(9) then
                return true
            end
        end
        return false
    end
}
local original_check_for_buy_space = G.FUNCS.check_for_buy_space
local original_can_select_card = G.FUNCS.can_select_card
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center and card.config.center.key == "j_chm_wine" then
        return true
    end
    return original_check_for_buy_space(card)
end

G.FUNCS.can_select_card = function(e)
    if e.config.ref_table and e.config.ref_table.config and e.config.ref_table.config.center and e.config.ref_table.config.center.key == "j_chm_wine" then
        e.config.colour = G.C.GREEN
        e.config.button = "use_card"
    else
        original_can_select_card(e)
    end
end

SMODS.Joker {
    key = "wonders",
    name = "Wonders",
    config = {
        extra = {
            xmult = 1.3,
            dollars = 1
        }
    },
    pos = { x = 5, y = 4 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.individual and context.cardarea == G.hand and context.other_card:get_id() == 7 and not context.end_of_round then
            local count = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card.base.id == 7 then
                    count = count + 1
                end
            end
            if count > 0 then
                return {
                    dollars = count * card.ability.extra.dollars
                }
            end
        end
    end
}

SMODS.Joker {
    key = "pumpkin_costume",
    name = "Pumpkin Costume",
    config = {
        extra = {
            odds = 11,
            dollars = 10,
        }
    },
    pos = { x = 7, y = 2 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    pools = { ["chm_costumes"] = true, },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_pumpkincostume")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            if SMODS.pseudorandom_probability(card, "j_chm_pumpkincostume", 1, card.ability.extra.odds) then
                local random_seal = SMODS.poll_seal({
                    mod = 10,
                    guaranteed = true
                })
                if random_seal then
                    context.other_card:set_seal(random_seal, true)
                end
                return {
                    message = "Card Modified!",
                    colour = G.C.BLUE
                }
            end
        end
        if context.selling_self then
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
                                    end
                                    G.GAME.joker_buffer = 0
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
                        return true
                    end,
                    colour = G.C.BLUE
                }
            }
        end
    end
}

SMODS.Joker {
    key = "tobiko",
    name = "Tobiko",
    config = {
        extra = {
            rerolls = 4,
            odds = 4,
            reroll_mod = 1,
            sell_value = 0,
        }
    },
    pos = { x = 6, y = 3 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    pools = { ["sushi"] = true },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_tobiko")
        return {
            vars = {
                card.ability.extra.rerolls,
                numerator,
                denominator,
                card.ability.extra.reroll_mod,
                card.ability.extra.sell_value,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.reroll_shop and SMODS.pseudorandom_probability(card, "tobiko_reroll_shop", 1, card.ability.extra.odds, "j_chm_tobiko", false) and not context.blueprint then
            if card.ability.extra.rerolls <= card.ability.extra.rerolls - card.ability.extra.reroll_mod then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                card.ability.extra.rerolls = math.max(0, card.ability.extra.rerolls - card.ability.extra.reroll_mod)
                if G.jokers and G.jokers.cards then
                    for _, j in ipairs(G.jokers.cards) do
                        if j == card then
                            SMODS.change_free_rerolls(-card.ability.extra.reroll_mod)
                            break
                        end
                    end
                end
                return {
                    message = "-" .. card.ability.extra.reroll_mod .. " Reroll" .. (card.ability.extra.reroll_mod > 1 and "s" or ""),
                    colour = G.C.GREEN
                }
            end
        end
        if context.selling_self then
            if G.jokers and G.jokers.cards then
                for _, target_card in ipairs(G.jokers.cards) do
                    if target_card ~= card and target_card.set_cost then
                        target_card.ability.extra_value = card.ability.extra.sell_value
                        target_card:set_cost()
                    end
                end
            end
            return {
                message = "Reset",
                colour = G.C.RED
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(card.ability.extra.rerolls)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(-(card.ability.extra.rerolls))
    end
}

SMODS.Joker{
    key = "watercolors",
    name = "Watercolors",
    config = { extra = { play_size = 2 } },
    pos = { x = 2, y = 4 },
    cost = 5,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        return { vars = { card.ability.extra.play_size } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (#context.full_hand == card.ability.extra.play_size and G.GAME.current_round.hands_left == 0) then
                context.other_card:set_edition("e_holo", true)
                return {
                    message = "Holographic!",
                    colour = G.C.DARK_EDITION
                }
            end
        end
    end
}