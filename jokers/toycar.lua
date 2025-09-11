SMODS.Joker{ --Toy Car
    key = "toycar",
    config = {
        extra = {
            moneyvar = 1
        }
    },
    loc_txt = {
        ['name'] = 'Toy Car',
        ['text'] = {
            [1] = 'Earn {C:attention}$#1# {}when {C:attention}Blind{} is skipped',
            [2] = 'Increases by {C:attention}$2{} at end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.moneyvar}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.moneyvar = (card.ability.extra.moneyvar) + 2
                    return true
                end
                }
        end
        if context.skip_blind  then
                return {
                    dollars = card.ability.extra.moneyvar
                }
        end
    end
}