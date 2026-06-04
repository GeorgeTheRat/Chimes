SMODS.Consumable {
    key = "fish",
    name = "Fish",
    set = "Lenormand",
    pos = { x = 3, y = 3 },
    config = { extra = { create = 1 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.create } }
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                SMODS.add_card({
                    set = "sushi",
                    area = G.jokers,
                    key_append = "c_chm_fish"
                })
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end
}