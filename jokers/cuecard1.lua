SMODS.Joker{ --Cue Card
    key = "cuecard1",
    config = {
        extra = {
            woxihuanchibingxilin = 1,
            dollars = 5,
            respect = 0,
            rental = 0
        }
    },
    loc_txt = {
        ['name'] = 'Cue Card',
        ['text'] = {
            [1] = 'At {C:attention}end of round{},',
            [2] = 'enact a {C:attention}random{} effect'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_solo_jokers"] = true },

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if (card.ability.extra.woxihuanchibingxilin or 0) == 1 then
                return {
                    dollars = card.ability.extra.dollars
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 2 then
                return {
                    func = function()
            local created_joker = false
    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        created_joker = true
        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker' })
                    if joker_card then
                        
                        
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
        end
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 3 then
                if #G.jokers.cards > 1 then
  G.jokers:unhighlight_all()
  G.E_MANAGER:add_event(Event({
      trigger = 'before',
      func = function()
          G.E_MANAGER:add_event(Event({
              func = function()
                  G.jokers:shuffle('aajk')
                  play_sound('cardSlide1', 0.85)
                  return true
              end,
          }))
          delay(0.15)
          G.E_MANAGER:add_event(Event({
              func = function()
                  G.jokers:shuffle('aajk')
                  play_sound('cardSlide1', 1.15)
                  return true
              end
          }))
          delay(0.15)
          G.E_MANAGER:add_event(Event({
              func = function()
                  G.jokers:shuffle('aajk')
                  play_sound('cardSlide1', 1)
                  return true
              end
          }))
        delay(0.5)
        return true
      end
    }))
  end
                return {
                    message = "Shuffle!"
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 4 then
                if #G.jokers.cards > 0 then
    local available_jokers = {}
      for i, joker in ipairs(G.jokers.cards) do
        table.insert(available_jokers, joker)
      end
      pseudorandom_element(available_jokers, pseudoseed('flip_joker')):flip()
    end
                return {
                    message = "Flip!"
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 6 then
                return {
                    func = function()
                local available_jokers = {}
                for i, joker in ipairs(G.jokers.cards) do
                    table.insert(available_jokers, joker)
                end
                local target_joker = #available_jokers > 0 and pseudorandom_element(available_jokers, pseudoseed('copy_joker')) or nil
                
                if target_joker and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local copied_joker = copy_card(target_joker, nil, nil, nil, target_joker.edition and target_joker.edition.negative)
                            copied_joker:add_sticker('rental', true)
                            copied_joker:add_to_deck()
                            G.jokers:emplace(copied_joker)
                        G.GAME.joker_buffer = 0
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex'), colour = G.C.GREEN})
                end
                    return true
                end
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 5 then
                local voucher_key = pseudorandom_element(G.P_CENTER_POOLS.Voucher, "327b0d86").key
    local voucher_card = SMODS.create_card{area = G.play, key = voucher_key}
    voucher_card:start_materialize()
    voucher_card.cost = 0
    G.play:emplace(voucher_card)
    delay(0.8)
    voucher_card:redeem()

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
            voucher_card:start_dissolve()                
            return true
        end
    }))
                return {
                    message = nil
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 7 then
                return {
                    func = function()local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local random_sets = {'Tarot', 'Planet', 'Spectral'}
                            local random_set = random_sets[math.random(1, #random_sets)]
                            SMODS.add_card{set=random_set, soulable = nil, key_append='joker_forge_' .. random_set:lower()}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_consumable'), colour = G.C.PURPLE})
                    end
                    return true
                end
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 8 then
                return {
                    func = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                    local tag = Tag(selected_tag)
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
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
                    return true
                end,
                    message = "Created Tag!"
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 9 then
                return {
                    func = function()
            local target_cards = {}
            for i, consumable in ipairs(G.consumeables.cards) do
                table.insert(target_cards, consumable)
            end
            if #target_cards > 0 then
                local card_to_destroy = pseudorandom_element(target_cards, pseudoseed('destroy_consumable'))
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_to_destroy:start_dissolve()
                        return true
                    end
                }))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed Consumable!", colour = G.C.RED})
            end
                    return true
                end
                }
            elseif (card.ability.extra.woxihuanchibingxilin or 0) == 9 then
                local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card'))
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
                draw_card(G.play, G.deck, 90, 'up')
                SMODS.calculate_context({ playing_card_added = true, cards = { new_card } })
            end,
                    message = "Added Card!"
                }
            else
                return {
                    func = function()
                    card.ability.extra.woxihuanchibingxilin = pseudorandom('woxihuanchibingxilin_3526760d', 1, 10)
                    return true
                end
                }
            end
        end
    end
}