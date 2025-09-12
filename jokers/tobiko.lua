SMODS.Joker{ --Tobiko
    key = "tobiko",
    config = {
        extra = {
            chip = 50,
            mults = 10,
            multsextra = 1.5,
            depender = 0,
            respect = 0,
            start_dissolve = 0,
            y = 0
        }
    },
    loc_txt = {
        ['name'] = 'Tobiko',
        ['text'] = {
            [1] = '{C:blue}+#1#{} chips, {C:red}+#2#{} mult, {X:red,C:white}X#3#{} Mult',
            [2] = 'At end of round, {C:red}lose{} the next benefit and',
            [3] = 'create a random {C:attention}Joker{} with the corresponding {C:edition}edition{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_sushi"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chip, card.ability.extra.mults, card.ability.extra.multsextra}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chip,
                    extra = {
                        mult = card.ability.extra.mults,
                        extra = {
                            Xmult = card.ability.extra.multsextra
                        }
                        }
                }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if (card.ability.extra.depender or 0) == 1 then
                return {
                    func = function()
                    card.ability.extra.chip = 0
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
                    local joker_card = SMODS.add_card({ set = 'Joker' })
                    if joker_card then
                        joker_card:set_edition("e_foil", true)
                        
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            end
            if created_joker then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
            end
            return true
        end,
                        colour = G.C.BLUE
                        }
                }
            elseif (card.ability.extra.depender or 0) == 2 then
                return {
                    func = function()
                    card.ability.extra.mults = 0
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
                    local joker_card = SMODS.add_card({ set = 'Joker' })
                    if joker_card then
                        joker_card:set_edition("e_holo", true)
                        
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            end
            if created_joker then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
            end
            return true
        end,
                        colour = G.C.BLUE
                        }
                }
            elseif (card.ability.extra.depender or 0) == 3 then
                return {
                    func = function()
                    card.ability.extra.multsextra = 1
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
                    local joker_card = SMODS.add_card({ set = 'Joker' })
                    if joker_card then
                        joker_card:set_edition("e_polychrome", true)
                        
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            end
            if created_joker then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
            end
            return true
        end,
                        colour = G.C.BLUE,
                        extra = {
                            func = function()
                card:start_dissolve()
                return true
            end,
                            message = "Eaten!",
                            colour = G.C.RED
                        }
                        }
                }
            else
                return {
                    func = function()
                    card.ability.extra.depender = (card.ability.extra.depender) + 1
                    return true
                end
                }
            end
        end
    end
}