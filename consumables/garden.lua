SMODS.Consumable {
    key = 'garden',
    set = 'lenormand',
    pos = { x = 0, y = 1 },
    config = { extra = {
        lowestrankinhand = 0
    } },
    loc_txt = {
        name = 'Garden',
        text = {
        [1] = 'Earn {C:attention}5X{} the value of the',
        [2] = '{C:attention}lowest ranked card {}in hand as {C:money}money{}'
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
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "+"..tostring(((function() local min = 14; for _, card in ipairs(G.hand and G.hand.cards or {}) do if card.base.id < min then min = card.base.id end end; return min end)()) * 5).." $", colour = G.C.MONEY})
                    ease_dollars(((function() local min = 14; for _, card in ipairs(G.hand and G.hand.cards or {}) do if card.base.id < min then min = card.base.id end end; return min end)()) * 5, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}