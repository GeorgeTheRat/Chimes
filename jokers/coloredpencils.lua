SMODS.Joker{ --Colored Pencils
    key = "coloredpencils",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Colored Pencils',
        ['text'] = {
            [1] = 'If {C:attention}last hand{} of round',
            [2] = 'has only {C:attention}1{} card,',
            [3] = 'apply {C:edition}Polychrome{} to it when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (#context.full_hand == 1 and G.GAME.current_round.hands_left == 0) then
                context.other_card:set_edition("e_polychrome", true)
                return {
                    message = "Card Modified!"
                }
            end
        end
    end
}