SMODS.Joker{ --Brain
    key = "brain",
    config = {
        extra = {
            mult1 = 2,
            mult2 = 1,
            odds = 6
        }
    },
    loc_txt = {
        ['name'] = 'Brain',
        ['text'] = {
            [1] = '{C:red}+#1# {}Mult',
            [2] = 'Whenever a hand is played,',
            [3] = '{C:green}#3# in #4# {}chance for this Joker to',
            [4] = 'gain {C:red}+#2# {}Mult and further increase',
            [5] = 'the Mult increment by {C:attention}1{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
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

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_solo_brain') 
        return {vars = {card.ability.extra.mult1, card.ability.extra.mult2, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                return {
                    mult = card.ability.extra.mult1
                ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_735ee1a4', 1, card.ability.extra.odds, 'j_solo_brain', false) then
              local mult2_value = card.ability.extra.mult2
                        card.ability.extra.mult1 = (card.ability.extra.mult1) + card.ability.extra.mult2
                        card.ability.extra.mult2 = (card.ability.extra.mult2) + 1
                        
          end
                        return true
                    end
                }
            end
        end
    end
}