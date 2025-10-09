SMODS.Consumable {
    key = "tree",
    set = "Lenormand",
    pos = { x = 2, y = 3 },
    config = { extra = {
        cardsremovedfromdeck = 0
    } },
    loc_txt = {
        name = "Tree",
        text = {
        [1] = "Earn {C:money}$3{} for each card below",
        [2] = "{C:attention}52{} in your full deck",
        [3] = "{C:inactive}(Currently +$#1#){}"
    }
    },
    cost = 4,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {vars = {(((G.GAME.starting_deck_size - #(G.playing_cards or {})) or 0)) * 3}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    card_eval_status_text(used_card, "extra", nil, nil, nil, {message = "+"..tostring(((G.GAME.starting_deck_size - #(G.playing_cards or {}))) * 3).." $", colour = G.C.MONEY})
                    ease_dollars(((G.GAME.starting_deck_size - #(G.playing_cards or {}))) * 3, true)
                    return true
                end
            }))
            delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}