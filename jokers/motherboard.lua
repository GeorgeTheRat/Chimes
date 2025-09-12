SMODS.Joker{ --Motherboard
    key = "motherboard",
    config = {
        extra = {
            ice = 0
        }
    },
    loc_txt = {
        ['name'] = 'Motherboard',
        ['text'] = {
            [1] = '{C:blue}+#1# {}Chips,',
            [2] = 'this {C:attention}Joker{} gains {C:blue}+3 {}Chips',
            [3] = 'when a {C:green}listed chance{} is failed',
            [4] = 'and {C:red}-5{} Chips when',
            [5] = 'a {C:green}listed chance{} succeeds'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
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
    pools = { ["solo_solo_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.ice}}
    end,

    calculate = function(self, card, context)
        if context.pseudorandom_result  then
            if context.result then
                return {
                    func = function()
                    card.ability.extra.ice = math.max(0, (card.ability.extra.ice) - 5)
                    return true
                end
                }
            elseif not context.result then
                return {
                    func = function()
                    card.ability.extra.ice = (card.ability.extra.ice) + 3
                    return true
                end
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.ice
                }
        end
    end
}