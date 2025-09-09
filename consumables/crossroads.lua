SMODS.Consumable {
    key = 'crossroads',
    set = 'lenormand',
    pos = { x = 7, y = 0 },
    config = { extra = {
        odds = 2,
        copy_cards_amount = 3
    } },
    loc_txt = {
        name = 'Crossroads',
        text = {
        [1] = 'Select {C:attention}1{} card,',
        [2] = '{C:green}#1# in #2#{} chance to {C:red}destroy{}',
        [3] = 'it, otherwise {C:green}#1# in #2#{} chance to',
        [4] = 'create {C:attention}3{} copies of it'
    }
    },
    cost = 4,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'c_solo_crossroads')
        return {vars = {numerator, denominator}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if #G.hand.highlighted == 1 then
            if SMODS.pseudorandom_probability(card, 'group_0_f6bf59f6', 1, card.ability.extra.odds, 'c_solo_crossroads', false) then
                
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    SMODS.destroy_cards(G.hand.highlighted)
                    return true
                end
            }))
            delay(0.3)
            end
            if SMODS.pseudorandom_probability(card, 'group_1_9857b26b', 1, card.ability.extra.odds, 'c_solo_crossroads', false) then
                
                G.E_MANAGER:add_event(Event({
                func = function()
                    local _first_materialize = nil
                    local new_cards = {}
                    
                    for _, selected_card in pairs(G.hand.highlighted) do
                        for i = 1, card.ability.extra.copy_cards_amount do
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local copied_card = copy_card(selected_card, nil, nil, G.playing_card)
                            copied_card:add_to_deck()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            table.insert(G.playing_cards, copied_card)
                            G.hand:emplace(copied_card)
                            copied_card:start_materialize(nil, _first_materialize)
                            _first_materialize = true
                            new_cards[#new_cards + 1] = copied_card
                        end
                    end
                    
                    SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                    return true
                end
            }))
            delay(0.6)
            end
        end
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted == 1)
    end
}