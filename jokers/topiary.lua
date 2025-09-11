SMODS.Joker{ --Topiary
    key = "topiary",
    config = {
        extra = {
            pants = 1,
            odds = 10,
            odds2 = 10,
            odds3 = 10,
            odds4 = 10,
            odds5 = 10,
            odds6 = 10,
            odds7 = 10,
            odds8 = 10,
            odds9 = 10,
            odds10 = 10,
            odds11 = 10,
            odds12 = 10
        }
    },
    loc_txt = {
        ['name'] = 'Topiary',
        ['text'] = {
            [1] = 'Each {C:clubs}Club{} card held in hand',
            [2] = 'has a {C:green}1 in 10 {}chance to create',
            [3] = 'a {C:planet}Planet{} in collection order',
            [4] = '{C:inactive}(ex. Pluto, Mecury, Uranus){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 1) then
                if SMODS.pseudorandom_probability(card, 'group_0_9630fc7a', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_pluto', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 2) then
                if SMODS.pseudorandom_probability(card, 'group_0_a631b366', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_mercury', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 3) then
                if SMODS.pseudorandom_probability(card, 'group_0_f402dba8', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_uranus', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 4) then
                if SMODS.pseudorandom_probability(card, 'group_0_b71815f3', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_venus', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 5) then
                if SMODS.pseudorandom_probability(card, 'group_0_8c0f70f1', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_saturn', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 6) then
                if SMODS.pseudorandom_probability(card, 'group_0_dd8dc180', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_jupiter', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 7) then
                if SMODS.pseudorandom_probability(card, 'group_0_24049920', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_earth', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 8) then
                if SMODS.pseudorandom_probability(card, 'group_0_0a4e793f', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_mars', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 9) then
                if SMODS.pseudorandom_probability(card, 'group_0_f0987577', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_neptune', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 10) then
                if SMODS.pseudorandom_probability(card, 'group_0_9bc243c2', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_planet_x', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 11) then
                if SMODS.pseudorandom_probability(card, 'group_0_96efabb7', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_ceres', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            elseif (context.other_card:is_suit("Clubs") and (card.ability.extra.pants or 0) == 12) then
                if SMODS.pseudorandom_probability(card, 'group_0_0979b816', 1, card.ability.extra.odds, 'j_solo_topiary', false) then
              SMODS.calculate_effect({func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Planet', soulable = undefined, key = 'c_eris', key_append = 'joker_forge_planet'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                    end
                    return true
                end}, card)
                        SMODS.calculate_effect({func = function()
                    card.ability.extra.pants = (card.ability.extra.pants) + 1
                    return true
                end}, card)
          end
            end
        end
    end
}