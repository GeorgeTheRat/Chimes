SMODS.Consumable {
    key = "tree",
    name = "Tree",
    set = "Lenormand",
    pos = { x = 4, y = 0 },
    config = { extra = { dollars = 3 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                G.GAME.starting_deck_size or 52,
                math.max((G.playing_cards and (G.GAME.starting_deck_size - #G.playing_cards) or 0) * card.ability.extra.dollars, 0)
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
                play_sound("timpani")
                used_card:juice_up(0.3, 0.5)
                ease_dollars(math.max(0, (G.playing_cards and (G.GAME.starting_deck_size - #G.playing_cards) or 0) * card.ability.extra.dollars), true)
                return true
            end
        }))
        delay(0.6)
    end
}