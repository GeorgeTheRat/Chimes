SMODS.Joker{ --Conman
    key = "conman",
    config = {
        extra = {
            dollars = 15
        }
    },
    loc_txt = {
        ['name'] = 'Conman',
        ['text'] = {
            [1] = 'When {C:attention}Blind{} is selected, gain {C:attention}$15{} and {C:red}destroy{} this {C:attention}Joker{}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.setting_blind  then
                return {
                    dollars = card.ability.extra.dollars,
                    extra = {
                        func = function()
                card:undefined()
                return true
            end,
                        colour = G.C.RED
                        }
                }
        end
    end
}