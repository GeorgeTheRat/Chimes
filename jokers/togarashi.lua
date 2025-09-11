SMODS.Joker{ --Togarashi
    key = "togarashi",
    config = {
        extra = {
            redsuit = 0
        }
    },
    loc_txt = {
        ['name'] = 'Togarashi',
        ['text'] = {
            [1] = '{C:hearts}Hearts{} and {C:diamonds}Diamonds{} held in',
            [2] = 'hand add {C:red}+1{} Mult to this {C:attention}Joker{}',
            [3] = '{C:red}-3{} Mult when a {C:hearts}Heart{} or',
            [4] = '{C:diamonds}Diamond{} is scored',
            [5] = '{C:inactive}(currently +#1# mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.redsuit}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds") then
                return {
                    func = function()
                    card.ability.extra.redsuit = (card.ability.extra.redsuit) + 1
                    return true
                end
                }
            end
        end
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds") then
                card.ability.extra.redsuit = math.max(0, (card.ability.extra.redsuit) - 3)
            end
        end
    end
}