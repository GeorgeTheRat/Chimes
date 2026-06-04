SMODS.Enhancement {
    key = "old",
    name = "Old",
    pos = { x = 3, y = 0 },
    config = { extra = { levels = 2 } },
    atlas = "enhancement",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            local target_hand
            local available_hands = {}
            for hand, value in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(hand) then
                    table.insert(available_hands, hand)
                end
            end
            target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed("m_chm_old")) or "High Card"
            SMODS.calculate_effect({
                level_up = card.ability.extra.levels,
                level_up_hand = target_hand 
            }, card)
        end
    end
}