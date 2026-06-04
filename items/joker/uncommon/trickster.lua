SMODS.Joker {
    key = "trickster",
    name = "Trickster",
    config = { extra = { booster_limit = 1 } },
    pos = { x = 1, y = 4 },
    cost = 6,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.booster_limit } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.change_booster_limit(card.ability.extra.booster_limit)
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.change_booster_limit(-card.ability.extra.booster_limit)
                return true
            end
        }))
    end
}