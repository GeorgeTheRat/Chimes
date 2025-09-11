SMODS.Joker{ --Waterfall
    key = "waterfall",
    config = {
        extra = {
            runtrigger = 0
        }
    },
    loc_txt = {
        ['name'] = 'Waterfall',
        ['text'] = {
            [1] = 'Retrigger each played {C:attention}6{}, {C:attention}7{}, {C:attention}8{}, {C:attention}9{}, and {C:attention}10{}',
            [2] = 'once for each {C:attention}straight{} played this round',
            [3] = '{C:inactive}(Currently #1#){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 4
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
        return {vars = {card.ability.extra.runtrigger}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            if context.scoring_name == "Straight" then
                card.ability.extra.runtrigger = (card.ability.extra.runtrigger) + 1
            end
        end
        if context.repetition and context.cardarea == G.play  then
            if (context.other_card:get_id() == 10 or context.other_card:get_id() == 9 or context.other_card:get_id() == 8 or context.other_card:get_id() == 7 or context.other_card:get_id() == 6) then
                return {
                    repetitions = card.ability.extra.runtrigger,
                    message = localize('k_again_ex')
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.runtrigger = 0
                    return true
                end
                }
        end
    end
}