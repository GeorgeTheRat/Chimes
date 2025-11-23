SMODS.Joker {
    key = "celosia",
    name = "Celosia",
    config = {
        extra = {
            odds = 10,
            create = 1
        }
    },
    pos = { x = 3, y = 3 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_celosia")
        return {
            vars = {
                numerator,
                denominator,
                card.ability.extra.create
            } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Diamonds") then
            for i = 1, math.ceil(card.ability.extra.create) do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit - #G.consumeables.cards >= 0 then
                            play_sound("timpani")
                            card:juice_up(0.3, 0.5)
                            SMODS.add_card({
                                set = "Tarot",
                                edition = "negative",
                                key_append = "j_chm_celosia"
                            })
                        end
                        return true 
                    end
                }))
            end
            return {
                message = "+" .. tostring(card.ability.extra.create) .. " Tarot" .. (card.ability.extra.create > 1 and "s" or ""),
                colour = G.C.SECONDARY_SET.Tarot,
                card = context.other_card
            }
        end
    end
}

SMODS.Joker {
    key = "bonsai",
    name = "Bonsai",
    config = {
        extra = {
            odds = 10,
            create = 1
        }
    },
    pos = { x = 3, y = 0 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_bonsai")
        return {
            vars = { 
                numerator,
                denominator,
                card.ability.extra.create
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and context.other_card:is_suit("Hearts") and SMODS.pseudorandom_probability(card, "j_chm_bonsai", 1, card.ability.extra.odds) then
            for i = 1, math.ceil(card.ability.extra.create) do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            play_sound("timpani")
                            card:juice_up(0.3, 0.5)
                            SMODS.add_card({
                                set = "Lenormand",
                                key_append = "j_chm_bonsai"
                            })
                        end
                        return true 
                    end
                }))
            end
            return {
                message = "+" .. tostring(card.ability.extra.create) .. " Lenormand" .. (card.ability.extra.create > 1 and "s" or ""),
                colour = G.C.SECONDARY_SET.Lenormand,
                card = context.other_card
            }
        end
    end
}

SMODS.Joker {
    key = "orchid",
    name = "Orchid",
    config = {
        extra = {
            odds = 10,
            create = 1
        }
    },
    pos = { x = 3, y = 2 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
        loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_orchid")
        return {
            vars = { 
                numerator,
                denominator,
                card.ability.extra.create
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Spades") and SMODS.pseudorandom_probability(card, "j_chm_orchid", 1, card.ability.extra.odds) then
            for i = 1, math.ceil(card.ability.extra.create) do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            play_sound("timpani")
                            card:juice_up(0.3, 0.5)
                            SMODS.add_card({
                                set = "Spectral",
                                key_append = "j_chm_orchid"
                            })
                        end
                        return true
                    end
                }))
            end
            return {
                message = "+" .. tostring(card.ability.extra.create) .. " Spectral" .. (card.ability.extra.create > 1 and "s" or ""),
                colour = G.C.SECONDARY_SET.Spectral,
                card = context.other_card
            }
        end
    end
}

-- function for topiary
local function get_planet_pool()
    if not G.GAME.topiary_planet_pool then
        G.GAME.topiary_planet_pool = {}
        for k, v in pairs(G.P_CENTER_POOLS.Consumeables) do
            if v.set == "Planet" then
                table.insert(G.GAME.topiary_planet_pool, v)
            end
        end
    end
    return G.GAME.topiary_planet_pool
end

SMODS.Joker{
    key = "botton_pon",
    name = "Botton Pon",
    config = {
        extra = {
            odds = 10,
            create = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_botton_pon")
        return {
            vars = { 
                numerator,
                denominator,
                card.ability.extra.create
            }
        }
    end,
    pos = { x = 8, y = 3 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Clubs") and SMODS.pseudorandom_probability(card, "j_chm_botton_pon", 1, card.ability.extra.odds) then
            G.GAME.topiary_planet_index = G.GAME.topiary_planet_index or 1 -- start planet index
            local planet_pool = get_planet_pool()
            if #planet_pool > 0 then
                for i = 1, math.ceil(card.ability.extra.create) do
                    if G.GAME.topiary_planet_index < 1 or G.GAME.topiary_planet_index > #planet_pool then
                        G.GAME.topiary_planet_index = 1
                    end
                    local planet_data = planet_pool[G.GAME.topiary_planet_index]
                    if planet_data and type(planet_data) == "table" and planet_data.key then
                        local key = planet_data.key
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.4,
                            func = function()
                                if #G.consumeables.cards < G.consumeables.config.card_limit then
                                    play_sound("timpani")
                                    local success, planet = pcall(create_card, "Consumeable", G.consumeables, nil, nil, nil, nil, key, "j_chm_topiary")
                                    if success and planet and type(planet) == "table" then
                                        if planet.add_to_deck then pcall(planet.add_to_deck, planet) end
                                        if G.consumeables and G.consumeables.emplace then
                                            pcall(function() G.consumeables:emplace(planet) end)
                                        end
                                        card:juice_up(0.3, 0.5)
                                        return true
                                    end
                                end
                                return true
                            end
                        }))
                        G.GAME.topiary_planet_index = G.GAME.topiary_planet_index + 1
                        return {
                            message = "+" .. tostring(card.ability.extra.create) .. " Planet" .. (card.ability.extra.create > 1 and "s" or ""),
                            colour = G.C.SECONDARY_SET.Planet,
                            card = context.other_card
                        }
                    end
                end
            end
        end
    end
}

SMODS.Joker {
    key = "overgrown",
    name = "Overgrown Joker",
    config = { extra = { slots = 3 } },
    pos = { x = 4, y = 2 },
    cost = 5,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_overgrown
        return { vars = { card.ability.extra.slots } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
    end
}

SMODS.Joker {
    key = "togarashi",
    name = "Togarashi",
    config = {
        extra = {
            mult1 = 3,
            mult2_mod = 2,
            mult2 = 0,
        }
    },
    pos = { x = 7, y = 3 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult1,
                card.ability.extra.mult2_mod,
                card.ability.extra.mult2
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local red_cards = 0
            for _, v in ipairs(G.hand.cards) do
                if v:is_suit("Hearts") or v:is_suit("Diamonds") then
                    red_cards = red_cards + card.ability.extra.mult2_mod
                end
            end
            if red_cards > 0 then
                card.ability.extra.mult2 = card.ability.extra.mult2 + red_cards
                return {
                    message = "Upgrade!",
                    colour = G.C.MULT
                }
            end
        end
        if context.individual and context.cardarea == G.play and (context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds")) then
            return {
                mult = -card.ability.extra.mult1,
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult2,
            }
        end
    end
}

SMODS.Joker {
    key = "tako_nigiri",
    name = "Tako Nigiri",
    config = {
        extra = {
            create = 6,
            create_mod = 1,
            legendary = 0
        }
    },
    pos = { x = 4, y = 3 },
    cost = 8,
    rarity = 3,
    eternal_compat = false,
    atlas = "joker",
    pools = { ["chm_sushi"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.create,
                card.ability.extra.create_mod,
                card.ability.extra.legendary
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            local available_slots = (G.jokers and G.jokers.config.card_limit or 0) - #(G.jokers and G.jokers.cards or {})
            if card.ability.extra.create <= available_slots then
                for i = 1, math.ceil(card.ability.extra.create) do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({
                                set = "Joker",
                                rarity = "Rare"
                            })
                            if joker_card then
                                card_eval_status_text(card, "extra", nil, nil, nil, {
                                    message = localize("k_plus_joker"),
                                    colour = G.C.BLUE
                                })
                            end
                            return true
                        end
                    }))
                end
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.BLUE
                }
            elseif card.ability.extra.legendary <= 0 and available_slots > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local joker_card = SMODS.add_card({
                            set = "Joker",
                            rarity = "Legendary"
                        })
                        if joker_card then
                            card_eval_status_text(card, "extra", nil, nil, nil, {
                                message = localize("k_plus_joker"),
                                colour = G.C.BLUE
                            })
                        end
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.BLUE
                }
            end
        end
        
        if context.end_of_round and context.main_eval and G.GAME.blind.boss and not context.blueprint then
            if (card.ability.extra.numby or 0) ~= 0 then
                card.ability.extra.numby = math.max(0, card.ability.extra.numby - 1)
            end
        end
    end
}