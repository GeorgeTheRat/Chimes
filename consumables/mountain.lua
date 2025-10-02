SMODS.Consumable {
    key = 'mountain',
    set = 'lenormand',
    pos = { x = 3, y = 2 },
    config = { extra = {
        booster_slots_value = 1,
        voucher_slots_value = 1,
        hand_size_value = 1
    } },
    loc_txt = {
        name = 'Mountain',
        text = {
        [1] = '{C:attention}+1{} {C:attention}Voucher{} and {C:attention}Booster Pack {}slots,',
        [2] = '{C:red}-2{} hand size'
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
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Booster Slots", colour = G.C.BLUE})
                    SMODS.change_booster_limit(1)
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Voucher Slots", colour = G.C.BLUE})
                    SMODS.change_voucher_limit(1)
                    return true
                end
            }))
            delay(0.6)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "-"..tostring(1).." Hand Size", colour = G.C.RED})
                    G.hand:change_size(-1)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}