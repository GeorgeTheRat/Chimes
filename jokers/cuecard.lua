SMODS.Joker{ --Cue Card
    key = "cuecard",
    config = {
        extra = {
            woxihuanchibingxilin = 1,
            levels = 3,
            sell_value = 3,
            dollars = 15,
            most = 0,
            all_jokers = 0,
            rental = 0,
            respect = 0,
            perishable = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Cue Card',
        ['text'] = {
            [1] = 'When a {C:attention}Boss Blind{} is defeated,',
            [2] = 'enact a {C:attention}random{} positive effect'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_solo_jokers"] = true },

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            if (card.ability.extra.woxihuanchibingxilin or 0) == 1 then
                temp_played = 0
        temp_order = math.huge
        for hand, value in pairs(G.GAME.hands) do 
          if value.played > temp_played and value.visible then
            temp_played = value.played
            temp_order = value.order
            target_hand = hand
          else if value.played == temp_played and value.visible then
            if value.order < temp_order then
              temp_order = value.order
              target_hand = hand
            end
          end
          end
        end
                return {
                    level_up = card.ability.extra.levels,
      level_up_hand = target_hand,
                    message = localize('k_level_up_ex')
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 5 then
                return {
                    func = function()for i, target_card in ipairs(G.jokers.cards) do
                if target_card.set_cost then
            target_joker.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.sell_value
            target_joker:set_cost()
            end
        end
                    return true
                end,
                    message = "All Jokers +"..tostring(card.ability.extra.sell_value).." Sell Value"
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 3 then
                return {
                    func = function()
            local created_joker = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Common' })
                    if joker_card then
                        joker_card:set_edition("e_negative", true)
                        joker_card:add_sticker('rental', true)
                    end
                    
                    return true
                end
            }))
            
            if created_joker then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
            end
            return true
        end
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 4 then
                return {
                    func = function()
                local available_jokers = {}
                for i, joker in ipairs(G.jokers.cards) do
                    table.insert(available_jokers, joker)
                end
                local target_joker = #available_jokers > 0 and pseudorandom_element(available_jokers, pseudoseed('copy_joker')) or nil
                
                if target_joker then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local copied_joker = copy_card(target_joker, nil, nil, nil, target_joker.edition and target_joker.edition.negative)
                        copied_joker:set_edition("e_negative", true)
                            copied_joker:add_sticker('perishable', true)
                            copied_joker:add_to_deck()
                            G.jokers:emplace(copied_joker)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex'), colour = G.C.GREEN})
                end
                    return true
                end
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 2 then
                return {
                    func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'Tarot', soulable = nil, key = nil, key_append = 'joker_forge_tarot'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                    end
                    return true
                end,
                    extra = {
                        func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{set = 'lenormand', soulable = nil, key = nil, key_append = 'joker_forge_lenormand'}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_consumable'), colour = G.C.PURPLE})
                    end
                    return true
                end,
                        colour = G.C.PURPLE
                        }
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 6 then
                return {
                    dollars = card.ability.extra.dollars
                }
            else
                return {
                    func = function()
                    card.ability.extra.woxihuanchibingxilin = pseudorandom('woxihuanchibingxilin_f5486164', 1, 6)
                    return true
                end
                }
            end
        end
        if context.individual and context.cardarea == G.play  then
                card.ability.extra.woxihuanchibingxilin = pseudorandom('woxihuanchibingxilin_21554fb1', 1, 6)
        end
    end
}