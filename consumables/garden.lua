SMODS.Consumable {
    key = 'garden',
    set = 'lenormand',
    pos = { x = 0, y = 1 },
    config = { extra = {
        leftmostcardrank = 0
    } },
    loc_txt = {
        name = 'Garden',
        text = {
        [1] = 'Earn 5X the value of the leftmost crd in hand as money'
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
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(((G.hand and G.hand.cards[1] and G.hand.cards[1].base.id or 0)) * 5).." $", colour = G.C.MONEY})
                    ease_dollars(((G.hand and G.hand.cards[1] and G.hand.cards[1].base.id or 0)) * 5, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}