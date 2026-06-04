SMODS.Consumable {
    key = "stars",
    name = "Stars",
    set = "Lenormand",
    pos = { x = 5, y = 1 },
    config = { extra = { levels = 1 } },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card) 
        return {
            vars = {
                card.ability.extra.levels,
                G.GAME.skips or 0
            }
        }
    end,
    can_use = function(self, card) 
        return G.GAME.skips ~= 0
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        local target_hand
        local available_hands = {}
        for hand, value in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(hand) then
                table.insert(available_hands, hand)
            end
        end
        target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed("c_chm_stars")) or "High Card"
        SMODS.calculate_effect({
            level_up = card.ability.extra.levels * G.GAME.skips,
            level_up_hand = target_hand 
        }, used_card)
    end
}