SMODS.Joker{ --Paper
    key = "paper",
    config = {
        extra = {
            chips = 200,
            mult = -15
        }
    },
    loc_txt = {
        ['name'] = 'Paper',
        ['text'] = {
            [1] = '{C:blue}+200{} Chips',
            [2] = '{C:red}-15 {} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 2
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
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        mult = card.ability.extra.mult
                        }
                }
        end
    end
}