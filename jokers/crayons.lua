SMODS.Joker{ --Crayons
    key = "crayons",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Crayons',
        ['text'] = {
            [1] = 'If {C:attention}last hand{}',
            [2] = 'of round has exactly {C:attention}3{}',
            [3] = 'cards, apply {C:edition}Foil{} to them when scored'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 0,
        y = 1
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
            if (#context.full_hand == 3 and G.GAME.current_round.hands_left == 0) then
                context.other_card:set_edition("e_foil", true)
                return {
                    message = "Card Modified!"
                }
            end
        end
    end
}