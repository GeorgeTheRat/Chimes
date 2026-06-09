SMODS.Consumable {
    key = "scythe",
    name = "Scythe",
    set = "Lenormand",
    pos = { x = 9, y = 0 },
    config = {
        extra = {
            destroy = 1,
            dollars = 10
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.destroy,
                card.ability.extra.dollars,
                math.floor(G.GAME.dollars / card.ability.extra.dollars) or 0,
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        local destroyed_cards = {}
        local temp_hand = {}
        for _, playing_card in ipairs(G.hand.cards) do
            temp_hand[#temp_hand + 1] = playing_card
        end
        table.sort(temp_hand, function(a, b)
            return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
        end)
        pseudoshuffle(temp_hand, "c_chm_scythe")
        for i = 1, math.floor(G.GAME.dollars / card.ability.extra.dollars) do
            destroyed_cards[#destroyed_cards + 1] = temp_hand[i]
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        SMODS.destroy_cards(destroyed_cards)
        delay(0.5)
    end
}