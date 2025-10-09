SMODS.Joker {
    key = "california_roll",
    name = "California Roll",
    config = {
        extra = {
            a = 5,
            respect = 0
        }
    },
    loc_txt = {
        ["name"] = "California Roll",
        ["text"] = {
            [1] = "Create {C:attention}#1# {}random {C:attention}Jokers{} and",
            [2] = "consumables when this {C:attention}Joker{} is sold",
            [3] = "Decrease by {C:attention}1{} and create a {C:attention}Tag{}, {C:attention}Joker{}, and",
            [4] = "consumable when a{C:attention} playing card{} is added to deck"
        },
        ["unlock"] = {
            [1] = "Unlocked by default."
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = "joker",
    pools = {
        ["chm_ushi"] = true
    },
    loc_vars = function(self, info_queue, card)

        return {
            vars = {card.ability.extra.a}
        }
    end,
    calculate = function(self, card, context)
        if context.playing_card_added then
            if (card.ability.extra.a or 0) ~= 0 then
                return {
                    func = function()
                        for i = 1, math.min(undefined, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = "after",
                                delay = 0.4,
                                func = function()
                                    play_sound("timpani")
                                    local sets = {"Tarot", "Planet", "Spectral"}
                                    local random_set = pseudorandom_element(sets, "random_consumable_set")
                                    SMODS.add_card({
                                        set = random_set
                                    })
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)

                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                                message = localize("k_plus_consumable"),
                                colour = G.C.PURPLE
                            })
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            local created_joker = false
                            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                created_joker = true
                                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({
                                            set = "Joker"
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
                        colour = G.C.BLUE,
                        extra = {
                            func = function()
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local selected_tag =
                                            pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                                        local tag = Tag(selected_tag)
                                        if tag.name == "Orbital Tag" then
                                            local _poker_hands = {}
                                            for k, v in pairs(G.GAME.hands) do
                                                if v.visible then
                                                    _poker_hands[#_poker_hands + 1] = k
                                                end
                                            end
                                            tag.ability.orbital_hand =
                                                pseudorandom_element(_poker_hands, "jokerforge_orbital")
                                        end
                                        tag:set_ability()
                                        add_tag(tag)
                                        play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                                        return true
                                    end
                                }))
                                return true
                            end,
                            message = "Created Tag!",
                            colour = G.C.GREEN,
                            extra = {
                                func = function()
                                    card.ability.extra.a = math.max(0, (card.ability.extra.a) - 1)
                                    return true
                                end,
                                colour = G.C.RED
                            }
                        }
                    }
                }
            elseif (card.ability.extra.a or 0) == 0 then
                return {
                    func = function()
                        card:undefined()
                        return true
                    end
                }
            end
        end
        if context.selling_self then
            if (card.ability.extra.a or 0) == 5 then
                return {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({
                                        set = "Joker"
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
                    extra = {
                        func = function()
                            local created_joker = false
                            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                created_joker = true
                                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({
                                            set = "Joker"
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
                        colour = G.C.BLUE,
                        extra = {
                            func = function()
                                local created_joker = false
                                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                    created_joker = true
                                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            local joker_card = SMODS.add_card({
                                                set = "Joker"
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
                            colour = G.C.BLUE,
                            extra = {
                                func = function()
                                    local created_joker = false
                                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                        created_joker = true
                                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                        G.E_MANAGER:add_event(Event({
                                            func = function()
                                                local joker_card = SMODS.add_card({
                                                    set = "Joker"
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
                                colour = G.C.BLUE,
                                extra = {
                                    func = function()
                                        local created_joker = false
                                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                            created_joker = true
                                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                            G.E_MANAGER:add_event(Event({
                                                func = function()
                                                    local joker_card = SMODS.add_card({
                                                        set = "Joker"
                                                    })
                                                    if joker_card then

                                                    end
                                                    G.GAME.joker_buffer = 0
                                                    return true
                                                end
                                            }))
                                        end
                                        if created_joker then
                                            card_eval_status_text(context.blueprint_card or card, "extra", nil, nil,
                                                nil, {
                                                    message = localize("k_plus_joker"),
                                                    colour = G.C.BLUE
                                                })
                                        end
                                        return true
                                    end,
                                    colour = G.C.BLUE,
                                    extra = {

                                        func = function()
                                            for i = 1, math.min(undefined, G.consumeables.config.card_limit -
                                                #G.consumeables.cards) do
                                                G.E_MANAGER:add_event(Event({
                                                    trigger = "after",
                                                    delay = 0.4,
                                                    func = function()
                                                        play_sound("timpani")
                                                        local sets = {"Tarot", "Planet", "Spectral"}
                                                        local random_set = pseudorandom_element(sets,
                                                            "random_consumable_set")
                                                        SMODS.add_card({
                                                            set = random_set
                                                        })
                                                        card:juice_up(0.3, 0.5)
                                                        return true
                                                    end
                                                }))
                                            end
                                            delay(0.6)

                                            if created_consumable then
                                                card_eval_status_text(context.blueprint_card or card, "extra", nil, nil,
                                                    nil, {
                                                        message = localize("k_plus_consumable"),
                                                        colour = G.C.PURPLE
                                                    })
                                            end
                                            return true
                                        end,
                                        colour = G.C.PURPLE,
                                        extra = {

                                            func = function()
                                                for i = 1, math.min(undefined, G.consumeables.config.card_limit -
                                                    #G.consumeables.cards) do
                                                    G.E_MANAGER:add_event(Event({
                                                        trigger = "after",
                                                        delay = 0.4,
                                                        func = function()
                                                            play_sound("timpani")
                                                            local sets = {"Tarot", "Planet", "Spectral"}
                                                            local random_set = pseudorandom_element(sets,
                                                                "random_consumable_set")
                                                            SMODS.add_card({
                                                                set = random_set
                                                            })
                                                            card:juice_up(0.3, 0.5)
                                                            return true
                                                        end
                                                    }))
                                                end
                                                delay(0.6)

                                                if created_consumable then
                                                    card_eval_status_text(context.blueprint_card or card, "extra", nil,
                                                        nil, nil, {
                                                            message = localize("k_plus_consumable"),
                                                            colour = G.C.PURPLE
                                                        })
                                                end
                                                return true
                                            end,
                                            colour = G.C.PURPLE,
                                            extra = {

                                                func = function()
                                                    for i = 1, math.min(undefined, G.consumeables.config.card_limit -
                                                        #G.consumeables.cards) do
                                                        G.E_MANAGER:add_event(Event({
                                                            trigger = "after",
                                                            delay = 0.4,
                                                            func = function()
                                                                play_sound("timpani")
                                                                local sets = {"Tarot", "Planet", "Spectral"}
                                                                local random_set = pseudorandom_element(sets,
                                                                    "random_consumable_set")
                                                                SMODS.add_card({
                                                                    set = random_set
                                                                })
                                                                card:juice_up(0.3, 0.5)
                                                                return true
                                                            end
                                                        }))
                                                    end
                                                    delay(0.6)

                                                    if created_consumable then
                                                        card_eval_status_text(context.blueprint_card or card, "extra",
                                                            nil, nil, nil, {
                                                                message = localize("k_plus_consumable"),
                                                                colour = G.C.PURPLE
                                                            })
                                                    end
                                                    return true
                                                end,
                                                colour = G.C.PURPLE,
                                                extra = {

                                                    func = function()
                                                        for i = 1, math.min(undefined,
                                                            G.consumeables.config.card_limit - #G.consumeables.cards) do
                                                            G.E_MANAGER:add_event(Event({
                                                                trigger = "after",
                                                                delay = 0.4,
                                                                func = function()
                                                                    play_sound("timpani")
                                                                    local sets = {"Tarot", "Planet", "Spectral"}
                                                                    local random_set = pseudorandom_element(sets,
                                                                        "random_consumable_set")
                                                                    SMODS.add_card({
                                                                        set = random_set
                                                                    })
                                                                    card:juice_up(0.3, 0.5)
                                                                    return true
                                                                end
                                                            }))
                                                        end
                                                        delay(0.6)

                                                        if created_consumable then
                                                            card_eval_status_text(context.blueprint_card or card,
                                                                "extra", nil, nil, nil, {
                                                                    message = localize("k_plus_consumable"),
                                                                    colour = G.C.PURPLE
                                                                })
                                                        end
                                                        return true
                                                    end,
                                                    colour = G.C.PURPLE,
                                                    extra = {

                                                        func = function()
                                                            for i = 1, math.min(undefined, G.consumeables.config
                                                                .card_limit - #G.consumeables.cards) do
                                                                G.E_MANAGER:add_event(Event({
                                                                    trigger = "after",
                                                                    delay = 0.4,
                                                                    func = function()
                                                                        play_sound("timpani")
                                                                        local sets = {"Tarot", "Planet", "Spectral"}
                                                                        local random_set = pseudorandom_element(sets,
                                                                            "random_consumable_set")
                                                                        SMODS.add_card({
                                                                            set = random_set
                                                                        })
                                                                        card:juice_up(0.3, 0.5)
                                                                        return true
                                                                    end
                                                                }))
                                                            end
                                                            delay(0.6)

                                                            if created_consumable then
                                                                card_eval_status_text(context.blueprint_card or card,
                                                                    "extra", nil, nil, nil, {
                                                                        message = localize("k_plus_consumable"),
                                                                        colour = G.C.PURPLE
                                                                    })
                                                            end
                                                            return true
                                                        end,
                                                        colour = G.C.PURPLE
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            elseif (card.ability.extra.a or 0) == 4 then
                return {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({
                                        set = "Joker"
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
                    extra = {
                        func = function()
                            local created_joker = false
                            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                created_joker = true
                                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({
                                            set = "Joker"
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
                        colour = G.C.BLUE,
                        extra = {
                            func = function()
                                local created_joker = false
                                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                    created_joker = true
                                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            local joker_card = SMODS.add_card({
                                                set = "Joker"
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
                            colour = G.C.BLUE,
                            extra = {
                                func = function()
                                    local created_joker = false
                                    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                        created_joker = true
                                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                        G.E_MANAGER:add_event(Event({
                                            func = function()
                                                local joker_card = SMODS.add_card({
                                                    set = "Joker"
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
                                colour = G.C.BLUE,
                                extra = {

                                    func = function()
                                        for i = 1, math.min(undefined,
                                            G.consumeables.config.card_limit - #G.consumeables.cards) do
                                            G.E_MANAGER:add_event(Event({
                                                trigger = "after",
                                                delay = 0.4,
                                                func = function()
                                                    play_sound("timpani")
                                                    local sets = {"Tarot", "Planet", "Spectral"}
                                                    local random_set = pseudorandom_element(sets,
                                                        "random_consumable_set")
                                                    SMODS.add_card({
                                                        set = random_set
                                                    })
                                                    card:juice_up(0.3, 0.5)
                                                    return true
                                                end
                                            }))
                                        end
                                        delay(0.6)

                                        if created_consumable then
                                            card_eval_status_text(context.blueprint_card or card, "extra", nil, nil,
                                                nil, {
                                                    message = localize("k_plus_consumable"),
                                                    colour = G.C.PURPLE
                                                })
                                        end
                                        return true
                                    end,
                                    colour = G.C.PURPLE,
                                    extra = {

                                        func = function()
                                            for i = 1, math.min(undefined, G.consumeables.config.card_limit -
                                                #G.consumeables.cards) do
                                                G.E_MANAGER:add_event(Event({
                                                    trigger = "after",
                                                    delay = 0.4,
                                                    func = function()
                                                        play_sound("timpani")
                                                        local sets = {"Tarot", "Planet", "Spectral"}
                                                        local random_set = pseudorandom_element(sets,
                                                            "random_consumable_set")
                                                        SMODS.add_card({
                                                            set = random_set
                                                        })
                                                        card:juice_up(0.3, 0.5)
                                                        return true
                                                    end
                                                }))
                                            end
                                            delay(0.6)

                                            if created_consumable then
                                                card_eval_status_text(context.blueprint_card or card, "extra", nil, nil,
                                                    nil, {
                                                        message = localize("k_plus_consumable"),
                                                        colour = G.C.PURPLE
                                                    })
                                            end
                                            return true
                                        end,
                                        colour = G.C.PURPLE,
                                        extra = {

                                            func = function()
                                                for i = 1, math.min(undefined, G.consumeables.config.card_limit -
                                                    #G.consumeables.cards) do
                                                    G.E_MANAGER:add_event(Event({
                                                        trigger = "after",
                                                        delay = 0.4,
                                                        func = function()
                                                            play_sound("timpani")
                                                            local sets = {"Tarot", "Planet", "Spectral"}
                                                            local random_set = pseudorandom_element(sets,
                                                                "random_consumable_set")
                                                            SMODS.add_card({
                                                                set = random_set
                                                            })
                                                            card:juice_up(0.3, 0.5)
                                                            return true
                                                        end
                                                    }))
                                                end
                                                delay(0.6)

                                                if created_consumable then
                                                    card_eval_status_text(context.blueprint_card or card, "extra", nil,
                                                        nil, nil, {
                                                            message = localize("k_plus_consumable"),
                                                            colour = G.C.PURPLE
                                                        })
                                                end
                                                return true
                                            end,
                                            colour = G.C.PURPLE,
                                            extra = {

                                                func = function()
                                                    for i = 1, math.min(undefined, G.consumeables.config.card_limit -
                                                        #G.consumeables.cards) do
                                                        G.E_MANAGER:add_event(Event({
                                                            trigger = "after",
                                                            delay = 0.4,
                                                            func = function()
                                                                play_sound("timpani")
                                                                local sets = {"Tarot", "Planet", "Spectral"}
                                                                local random_set = pseudorandom_element(sets,
                                                                    "random_consumable_set")
                                                                SMODS.add_card({
                                                                    set = random_set
                                                                })
                                                                card:juice_up(0.3, 0.5)
                                                                return true
                                                            end
                                                        }))
                                                    end
                                                    delay(0.6)

                                                    if created_consumable then
                                                        card_eval_status_text(context.blueprint_card or card, "extra",
                                                            nil, nil, nil, {
                                                                message = localize("k_plus_consumable"),
                                                                colour = G.C.PURPLE
                                                            })
                                                    end
                                                    return true
                                                end,
                                                colour = G.C.PURPLE
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            elseif (card.ability.extra.a or 0) == 3 then
                return {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({
                                        set = "Joker"
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
                    extra = {
                        func = function()
                            local created_joker = false
                            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                created_joker = true
                                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({
                                            set = "Joker"
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
                        colour = G.C.BLUE,
                        extra = {
                            func = function()
                                local created_joker = false
                                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                    created_joker = true
                                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            local joker_card = SMODS.add_card({
                                                set = "Joker"
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
                            colour = G.C.BLUE,
                            extra = {

                                func = function()
                                    for i = 1, math.min(undefined,
                                        G.consumeables.config.card_limit - #G.consumeables.cards) do
                                        G.E_MANAGER:add_event(Event({
                                            trigger = "after",
                                            delay = 0.4,
                                            func = function()
                                                play_sound("timpani")
                                                local sets = {"Tarot", "Planet", "Spectral"}
                                                local random_set = pseudorandom_element(sets, "random_consumable_set")
                                                SMODS.add_card({
                                                    set = random_set
                                                })
                                                card:juice_up(0.3, 0.5)
                                                return true
                                            end
                                        }))
                                    end
                                    delay(0.6)

                                    if created_consumable then
                                        card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                                            message = localize("k_plus_consumable"),
                                            colour = G.C.PURPLE
                                        })
                                    end
                                    return true
                                end,
                                colour = G.C.PURPLE,
                                extra = {

                                    func = function()
                                        for i = 1, math.min(undefined,
                                            G.consumeables.config.card_limit - #G.consumeables.cards) do
                                            G.E_MANAGER:add_event(Event({
                                                trigger = "after",
                                                delay = 0.4,
                                                func = function()
                                                    play_sound("timpani")
                                                    local sets = {"Tarot", "Planet", "Spectral"}
                                                    local random_set = pseudorandom_element(sets,
                                                        "random_consumable_set")
                                                    SMODS.add_card({
                                                        set = random_set
                                                    })
                                                    card:juice_up(0.3, 0.5)
                                                    return true
                                                end
                                            }))
                                        end
                                        delay(0.6)

                                        if created_consumable then
                                            card_eval_status_text(context.blueprint_card or card, "extra", nil, nil,
                                                nil, {
                                                    message = localize("k_plus_consumable"),
                                                    colour = G.C.PURPLE
                                                })
                                        end
                                        return true
                                    end,
                                    colour = G.C.PURPLE,
                                    extra = {

                                        func = function()
                                            for i = 1, math.min(undefined, G.consumeables.config.card_limit -
                                                #G.consumeables.cards) do
                                                G.E_MANAGER:add_event(Event({
                                                    trigger = "after",
                                                    delay = 0.4,
                                                    func = function()
                                                        play_sound("timpani")
                                                        local sets = {"Tarot", "Planet", "Spectral"}
                                                        local random_set = pseudorandom_element(sets,
                                                            "random_consumable_set")
                                                        SMODS.add_card({
                                                            set = random_set
                                                        })
                                                        card:juice_up(0.3, 0.5)
                                                        return true
                                                    end
                                                }))
                                            end
                                            delay(0.6)

                                            if created_consumable then
                                                card_eval_status_text(context.blueprint_card or card, "extra", nil, nil,
                                                    nil, {
                                                        message = localize("k_plus_consumable"),
                                                        colour = G.C.PURPLE
                                                    })
                                            end
                                            return true
                                        end,
                                        colour = G.C.PURPLE
                                    }
                                }
                            }
                        }
                    }
                }
            elseif (card.ability.extra.a or 0) == 2 then
                return {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({
                                        set = "Joker"
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
                    extra = {
                        func = function()
                            local created_joker = false
                            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                created_joker = true
                                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({
                                            set = "Joker"
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
                        colour = G.C.BLUE,
                        extra = {

                            func = function()
                                for i = 1, math.min(undefined, G.consumeables.config.card_limit - #G.consumeables.cards) do
                                    G.E_MANAGER:add_event(Event({
                                        trigger = "after",
                                        delay = 0.4,
                                        func = function()
                                            play_sound("timpani")
                                            local sets = {"Tarot", "Planet", "Spectral"}
                                            local random_set = pseudorandom_element(sets, "random_consumable_set")
                                            SMODS.add_card({
                                                set = random_set
                                            })
                                            card:juice_up(0.3, 0.5)
                                            return true
                                        end
                                    }))
                                end
                                delay(0.6)

                                if created_consumable then
                                    card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                                        message = localize("k_plus_consumable"),
                                        colour = G.C.PURPLE
                                    })
                                end
                                return true
                            end,
                            colour = G.C.PURPLE,
                            extra = {

                                func = function()
                                    for i = 1, math.min(undefined,
                                        G.consumeables.config.card_limit - #G.consumeables.cards) do
                                        G.E_MANAGER:add_event(Event({
                                            trigger = "after",
                                            delay = 0.4,
                                            func = function()
                                                play_sound("timpani")
                                                local sets = {"Tarot", "Planet", "Spectral"}
                                                local random_set = pseudorandom_element(sets, "random_consumable_set")
                                                SMODS.add_card({
                                                    set = random_set
                                                })
                                                card:juice_up(0.3, 0.5)
                                                return true
                                            end
                                        }))
                                    end
                                    delay(0.6)

                                    if created_consumable then
                                        card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                                            message = localize("k_plus_consumable"),
                                            colour = G.C.PURPLE
                                        })
                                    end
                                    return true
                                end,
                                colour = G.C.PURPLE
                            }
                        }
                    }
                }
            elseif (card.ability.extra.a or 0) == 1 then
                return {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({
                                        set = "Joker"
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
                    extra = {

                        func = function()
                            for i = 1, math.min(undefined, G.consumeables.config.card_limit - #G.consumeables.cards) do
                                G.E_MANAGER:add_event(Event({
                                    trigger = "after",
                                    delay = 0.4,
                                    func = function()
                                        play_sound("timpani")
                                        local sets = {"Tarot", "Planet", "Spectral"}
                                        local random_set = pseudorandom_element(sets, "random_consumable_set")
                                        SMODS.add_card({
                                            set = random_set
                                        })
                                        card:juice_up(0.3, 0.5)
                                        return true
                                    end
                                }))
                            end
                            delay(0.6)

                            if created_consumable then
                                card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                                    message = localize("k_plus_consumable"),
                                    colour = G.C.PURPLE
                                })
                            end
                            return true
                        end,
                        colour = G.C.PURPLE
                    }
                }
            end
        end
    end
}
