SMODS.Joker{ --Punk Joker
    key = "punkjoker",
    config = {
        extra = {
            chipvar = 0
        }
    },
    loc_txt = {
        ['name'] = 'Punk Joker',
        ['text'] = {
            [1] = 'Gains {C:blue}+30{} Chips when a',
            [2] = '{C:spades}Spade{} or {C:clubs}Club{} is destroyed',
            [3] = '{C:inactive}(Currently +#1# Chips){}'
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
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chipvar}}
    end,

    calculate = function(self, card, context)
        if context.remove_playing_cards  then
            if (function()
    for k, removed_card in ipairs(context.removed) do
        if removed_card:is_suit("Spades") or removed_card:is_suit("Clubs") then
            return true
        end
    end
    return false
end)() then
                return {
                    func = function()
                    card.ability.extra.chipvar = (card.ability.extra.chipvar) + 30
                    return true
                end
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.chipvar
                }
        end
    end
}