SMODS.Joker{ --Good Fortune
    key = "goodfortune",
    config = {
        extra = {
            chips = 6,
            mult = 8
        }
    },
    loc_txt = {
        ['name'] = 'Good Fortune',
        ['text'] = {
            [1] = 'Each played {C:attention}6{} or {C:attention}8{} gives {C:blue}+6{} Chips',
            [2] = 'and {C:red}+8{} Mult when scored',
            [3] = '{C:red}Destroyed{} if a {C:attention}4{} if held in hand',
            [4] = 'when {C:blue}hand{} is played'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
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
        if context.individual and context.cardarea == G.play  then
            if (context.other_card:get_id() == 6 or context.other_card:get_id() == 8) then
                return {
                    chips = card.ability.extra.chips,
                    extra = {
                        mult = card.ability.extra.mult
                        }
                }
            end
        end
        if context.cardarea == G.hand and context.end_of_round  then
            if context.other_card:get_id() == 4 then
                return {
                    func = function()
                card:undefined()
                return true
            end
                }
            end
        end
    end
}