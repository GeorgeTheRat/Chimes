SMODS.Joker{ --Cue Card
    key = "cuecard2",
    config = {
        extra = {
            woxihuanchibingxilin = 1,
            dollars = 5,
            var1 = 0,
            start_dissolve = 0,
            n = 0,
            rental = 0,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Cue Card',
        ['text'] = {
            [1] = 'When a hand is played with',
            [2] = 'at least {C:attention}2{} discards remaining,',
            [3] = 'enact a {C:attention}random{} effect'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
        if context.cardarea == G.jokers and context.joker_main  then
            if (G.GAME.current_round.discards_left >= 2 and (card.ability.extra.var1 or 0) == 1) then
                return {
                    dollars = card.ability.extra.dollars
                }
            elseif (G.GAME.current_round.discards_left >= 2 and (card.ability.extra.var1 or 0) == 2) then
                local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card'))
                local base_card = create_playing_card({
                    front = card_front,
                    center = G.P_CENTERS.c_base
                }, G.discard, true, false, nil, true)
                
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local new_card = copy_card(base_card, nil, nil, G.playing_card)
                new_card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                G.deck:emplace(new_card)
                table.insert(G.playing_cards, new_card)
                
                base_card:remove()
                
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        new_card:start_materialize()
                        return true
                    end
                }))
                return {
                    message = "Added Card!"
                }
            elseif (G.GAME.current_round.discards_left >= 2 and (card.ability.extra.var1 or 0) == 3) then
                local created_consumable = false
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
                return {
                    message = created_consumable and localize('k_plus_consumable') or nil
                }
            elseif (G.GAME.current_round.discards_left >= 2 and (card.ability.extra.var1 or 0) == 4) then
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
                return {
                    message = "Created Tag!"
                }
            elseif (G.GAME.current_round.discards_left >= 2 and (card.ability.extra.var1 or 0) == 10) then
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
            elseif (G.GAME.current_round.discards_left >= 2 and (card.ability.extra.var1 or 0) == 9) then
                return {
                    func = function()
                card:start_dissolve()
                return true
            end
                }
            elseif (G.GAME.current_round.discards_left >= 2 and (card.ability.extra.var1 or 0) == 8) then
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
            elseif (G.GAME.current_round.discards_left >= 2 and (card.ability.extra.var1 or 0) == 7) then
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
            elseif (G.GAME.current_round.discards_left >= 2 and (card.ability.extra.var1 or 0) == 6) then
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
            elseif (G.GAME.current_round.discards_left >= 2 and (card.ability.extra.var1 or 0) == 5) then
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
                return {
                    message = created_joker and localize('k_plus_joker') or nil
                }
            end
        end
        if context.setting_blind  then
                return {
                    func = function()
                    card.ability.extra.woxihuanchibingxilin = pseudorandom('woxihuanchibingxilin_a923fd28', 1, 10)
                    return true
                end
                }
        end
        if context.individual and context.cardarea == G.play  then
                card.ability.extra.woxihuanchibingxilin = pseudorandom('woxihuanchibingxilin_e8164fe7', 1, 10)
        end
    end
}