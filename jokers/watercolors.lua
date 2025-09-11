SMODS.Joker{ --Watercolors
    key = "watercolors",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Watercolors',
        ['text'] = {
            [1] = 'If {C:attention}last hand{} of round',
            [2] = 'has exactly {C:attention}2{} cards,',
            [3] = 'apply {C:edition}Holographic{} to them when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (#context.full_hand == 2 and G.GAME.current_round.hands_left == 0) then
                context.other_card:set_edition("e_holo", true)
                return {
                    message = "Card Modified!"
                }
            end
        end
    end
}