SMODS.Consumable {
    key = "bear",
    name = "Bear",
    set = "Lenormand",
    pos = { x = 4, y = 1 },
    config = {
        extra = {
            losedollars = 20,
            fordollars = 25
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.losedollars,
                card.ability.extra.fordollars
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        if G.GAME.dollars and G.GAME.dollars >= card.ability.extra.fordollars then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    ease_dollars(-(math.floor((G.GAME.dollars or 0) / card.ability.extra.fordollars) * card.ability.extra.losedollars), true)
                    return true
                end
            }))
            delay(0.6)
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                card:juice_up(0.3, 0.5)
                play_sound("timpani")
                ease_dollars((G.GAME.dollars or 0) * 3, true)
                return true
            end
        }))
        delay(0.6)
    end
}