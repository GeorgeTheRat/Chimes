SMODS.Consumable {
    key = "garden",
    name = "Garden",
    set = "Lenormand",
    pos = { x = 9, y = 1 },
    config = { extra = { x_earn_value = 4 } },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 1
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_earn_value } }
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        local min_id = 15
        for _, c in ipairs(G.hand and G.hand.cards or {}) do
            if c.base and c.base.id and not SMODS.has_no_rank(c) and c.base.id < min_id then
                min_id = c.base.id
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                ease_dollars(min_id * card.ability.extra.x_earn_value, true)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end
}