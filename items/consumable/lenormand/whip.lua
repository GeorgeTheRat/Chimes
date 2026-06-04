SMODS.Consumable {
    key = "whip",
    name = "Whip",
    set = "Lenormand",
    pos = { x = 0, y = 1 },
    config = {
        extra = {
            destroy_count = 2,
            max_highlighted = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.destroy_count,
                card.ability.extra.max_highlighted
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted 
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.max_highlighted then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.2,
                func = function()
                    SMODS.destroy_cards(G.hand.highlighted)
                    return true
                end
            }))
            delay(0.3)
            local destroyed_cards = {}
            local temp_hand = {}
            local highlighted_cards = {}
            for _, highlighted_card in ipairs(G.hand.highlighted) do
                highlighted_cards[highlighted_card] = true
            end
            for _, playing_card in ipairs(G.hand.cards) do
                if not highlighted_cards[playing_card] then
                    temp_hand[#temp_hand + 1] = playing_card
                end
            end
            table.sort(temp_hand, function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end)
            pseudoshuffle(temp_hand, "c_chm_whip")
            for i = 1, card.ability.extra.destroy_count do
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
    end
}