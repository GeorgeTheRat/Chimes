SMODS.Joker{ --Hand Roll
    key = "handroll",
    config = {
        extra = {
            all = 4,
            handys = 0,
            handsremaining = 0,
            round = 0,
            start_dissolve = 0,
            y = 0
        }
    },
    loc_txt = {
        ['name'] = 'Hand Roll',
        ['text'] = {
            [1] = '{C:blue}+#1# {}hands when {C:attention}Blind{} is selected, earn',
            [2] = '{C:money}$#1# {}for each hand remaining at end of round',
            [3] = 'Decreases by {C:attention}1{} Hand and {C:money}$1{} at end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.all}}
    end,

    calculate = function(self, card, context)
        if context.setting_blind  then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.all).." Hand", colour = G.C.GREEN})
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.all
                return true
            end
                }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if (card.ability.extra.all or 0) <= 0 then
                return {
                    func = function()
                card:start_dissolve()
                return true
            end,
                    message = "Eaten!"
                }
            else
                local handys_value = card.ability.extra.handys
                return {
                    func = function()
                    card.ability.extra.handys = G.GAME.current_round.hands_left
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.handys = (card.ability.extra.handys) * 4
                    return true
                end,
                        colour = G.C.MULT,
                        extra = {
                            dollars = handys_value,
                            colour = G.C.MONEY,
                        extra = {
                            func = function()
                    card.ability.extra.all = math.max(0, (card.ability.extra.all) - 1)
                    return true
                end,
                            colour = G.C.RED
                        }
                        }
                        }
                }
            end
        end
    end
}