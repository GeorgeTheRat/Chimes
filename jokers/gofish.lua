SMODS.Joker{ --Go Fish
    key = "gofish",
    config = {
        extra = {
            card_draw = 6
        }
    },
    loc_txt = {
        ['name'] = 'Go Fish',
        ['text'] = {
            [1] = 'Whenever a {C:attention}5{} card hand',
            [2] = 'is played that has no {C:attention}#1#{}',
            [3] = 'or {C:attention}#2#{}, draw {C:attention}6{} cards to hand',
            [4] = '{C:attention}Ranks{} change at end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
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

    loc_vars = function(self, info_queue, card)
        return {vars = {localize((G.GAME.current_round.r1_card or {}).rank or 'Ace', 'ranks'), localize((G.GAME.current_round.r2_card or {}).rank or 'Ace', 'ranks')}}
    end,

    set_ability = function(self, card, initial)
        G.GAME.current_round.r1_card = { rank = 'Ace', id = 14 }
        G.GAME.current_round.r2_card = { rank = 'King', id = 13 }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (#context.full_hand >= 5 and (function()
    local rankFound = true
    for i, c in ipairs(context.full_hand) do
        if c:get_id() == G.GAME.current_round.r1_card.id then
            rankFound = false
            break
        end
    end
    
    return rankFound
end)() and (function()
    local rankFound = true
    for i, c in ipairs(context.full_hand) do
        if c:get_id() == G.GAME.current_round.r2_card.id then
            rankFound = false
            break
        end
    end
    
    return rankFound
end)()) then
                if G.GAME.blind.in_blind then
    SMODS.draw_cards(card.ability.extra.card_draw)
  end
                return {
                    message = "+"..tostring(card.ability.extra.card_draw).." Cards Drawn"
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
                if G.playing_cards then
                        local valid_r1_cards = {}
                        for _, v in ipairs(G.playing_cards) do
                            if not SMODS.has_no_rank(v) then
                                valid_r1_cards[#valid_r1_cards + 1] = v
                            end
                        end
                        if valid_r1_cards[1] then
                            local r1_card = pseudorandom_element(valid_r1_cards, pseudoseed('r1' .. G.GAME.round_resets.ante))
                            G.GAME.current_round.r1_card.rank = r1_card.base.value
                            G.GAME.current_round.r1_card.id = r1_card.base.id
                        end
                    end
                if G.playing_cards then
                        local valid_r2_cards = {}
                        for _, v in ipairs(G.playing_cards) do
                            if not SMODS.has_no_rank(v) then
                                valid_r2_cards[#valid_r2_cards + 1] = v
                            end
                        end
                        if valid_r2_cards[1] then
                            local r2_card = pseudorandom_element(valid_r2_cards, pseudoseed('r2' .. G.GAME.round_resets.ante))
                            G.GAME.current_round.r2_card.rank = r2_card.base.value
                            G.GAME.current_round.r2_card.id = r2_card.base.id
                        end
                    end
        end
    end
}