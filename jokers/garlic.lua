SMODS.Joker{ --Garlic
    key = "garlic",
    config = {
        extra = {
            gargle = 2.5,
            var1 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Garlic',
        ['text'] = {
            [1] = '{X:red,C:white}X#1#{} Mult, decreases by {X:red,C:white}X0.1{} for',
            [2] = 'every {C:enhanced}Unenhanced{} card in played hand'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_food"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gargle}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (function()
    local count = 0
    for _, playing_card in pairs(context.full_hand or {}) do
        if next(SMODS.get_enhancements(playing_card)) then
            count = count + 1
        end
    end
    return count == 4
end)() then
                card.ability.extra.var1 = math.max(0, (card.ability.extra.var1) - 0.1)
            elseif (function()
    local count = 0
    for _, playing_card in pairs(context.full_hand or {}) do
        if next(SMODS.get_enhancements(playing_card)) then
            count = count + 1
        end
    end
    return count == 3
end)() then
                card.ability.extra.var1 = math.max(0, (card.ability.extra.var1) - 0.2)
            elseif (function()
    local count = 0
    for _, playing_card in pairs(context.full_hand or {}) do
        if next(SMODS.get_enhancements(playing_card)) then
            count = count + 1
        end
    end
    return count == 2
end)() then
                card.ability.extra.var1 = math.max(0, (card.ability.extra.var1) - 0.3)
            elseif (function()
    local count = 0
    for _, playing_card in pairs(context.full_hand or {}) do
        if next(SMODS.get_enhancements(playing_card)) then
            count = count + 1
        end
    end
    return count == 1
end)() then
                card.ability.extra.var1 = math.max(0, (card.ability.extra.var1) - 0.4)
            elseif (function()
    local count = 0
    for _, playing_card in pairs(context.full_hand or {}) do
        if next(SMODS.get_enhancements(playing_card)) then
            count = count + 1
        end
    end
    return count == 0
end)() then
                card.ability.extra.var1 = math.max(0, (card.ability.extra.var1) - 0.5)
            else
                return {
                    Xmult = card.ability.extra.gargle
                }
            end
        end
    end
}