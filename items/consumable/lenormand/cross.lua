SMODS.Consumable {
    key = "cross",
    name = "Cross",
    set = "Lenormand",
    pos = { x = 5, y = 3 },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                local new_joker = SMODS.add_card({ set = "Joker", rarity = "Uncommon" })
                if new_joker then
                end
                    G.GAME.joker_buffer = 0
                end
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                local new_joker = SMODS.add_card({ set = "Joker", rarity = "Common" })
                if new_joker then
                end
                    G.GAME.joker_buffer = 0
                end
                used_card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
    end
}