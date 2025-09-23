SMODS.Consumable {
    key = 'bear',
    set = 'lenormand',
    pos = { x = 1, y = 0 },
    config = { extra = {
        dollars_value = 40,
        double_limit = 100000000000,
        double_limit = 20000000000
    } },
    loc_txt = {
        name = 'Bear',
        text = {
        [1] = 'Lose {C:red}-$40{} for every {C:money}$50 {}you have',
        [2] = '{C:attention}Quadruple{} Money'
    }
    },
    cost = 4,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    use = function(self, card, area, copier)
        local used_card = copier or card
            for i = 1, math.floor(lenient_bignum(G.GAME.dollars / 50)) do
              
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "-"..tostring(40).." $", colour = G.C.RED})
                    ease_dollars(-math.min(G.GAME.dollars, 40), true)
                    return true
                end
            }))
            delay(0.6)
          end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    used_card:juice_up(0.3, 0.5)
                    local double_amount = math.min(G.GAME.dollars, 100000000000)
                    ease_dollars(double_amount, true)
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    used_card:juice_up(0.3, 0.5)
                    local double_amount = math.min(G.GAME.dollars, 20000000000)
                    ease_dollars(double_amount, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}