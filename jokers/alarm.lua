SMODS.Joker{ --Alarm
    key = "alarm",
    config = {
        extra = {
            discardsusedthisround = 0,
            Xmult = 1.5
        }
    },
    loc_txt = {
        ['name'] = 'Alarm',
        ['text'] = {
            [1] = 'Cards in {C:attention}first hand{} of round give',
            [2] = '{X:red,C:white}X1.5{} Mult when scored if no',
            [3] = '{C:attention}discards{} have been used this round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
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
            if (G.GAME.current_round.hands_played == 0 and 0 == G.GAME.current_round.discards_used) then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}