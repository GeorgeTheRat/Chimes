SMODS.Enhancement {
    key = 'old',
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            levels = 2
        }
    },
    loc_txt = {
        name = 'Old',
        text = {
        [1] = 'Levels up a random',
        [2] = '{C:attention}poker hand{} by {C:attention}2{} levels',
        [3] = 'when {C:red}discarded{}'
    }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 5,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            local target_hand
                
                local available_hands = {}
                for hand, value in pairs(G.GAME.hands) do
                  if value.visible and value.level >= to_big(1) then
                    table.insert(available_hands, hand)
                  end
                end
                target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed('level_up_hand_enhanced')) or "High Card"
            return { level_up = card.ability.extra.levels,
                level_up_hand = target_hand }
        end
    end
}