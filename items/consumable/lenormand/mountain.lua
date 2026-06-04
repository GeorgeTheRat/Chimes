SMODS.Consumable {
    key = "mountain",
    name = "Mountain",
    set = "Lenormand",
    pos = { x = 0, y = 2 },
    config = {
        extra = {
            booster_value = 1,
            hand_size_value = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.booster_value,
                G.GAME.mountain_minus or 1 
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                SMODS.change_booster_limit(card.ability.extra.booster_value)
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                G.GAME.mountain_minus = G.GAME.mountain_minus or 1
                G.hand:change_size(-G.GAME.mountain_minus)
                G.GAME.mountain_minus = G.GAME.mountain_minus + 1
                return true
            end
        }))
    end
}