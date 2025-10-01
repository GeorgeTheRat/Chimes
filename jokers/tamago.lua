SMODS.Joker{ --Tamago
    key = "tamago",
    config = {
        extra = {
            ten = 10,
            sell_value = 4,
            explode = 0,
            y = 0
        }
    },
    loc_txt = {
        ['name'] = 'Tamago',
        ['text'] = {
            [1] = 'Sell this card to gain {C:money}$#1#{}',
            [2] = 'Decrease by {C:money}$2{} and increase',
            [3] = '{C:attention}sell value{} of the {C:attention}Joker{} to the right by {C:money}$4{}',
            [4] = 'whenever a {C:attention}Blind{} is skipped'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_sushi"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.ten}}
    end,

    calculate = function(self, card, context)
        if context.selling_self  then
                return {
                    dollars = card.ability.extra.ten
                }
        end
        if context.skip_blind  then
            if (card.ability.extra.ten or 0) == 0 then
                return {
                    func = function()
                card:explode()
                return true
            end,
                    message = "Eaten!"
                }
            else
                return {
                    func = function()local my_pos = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
                break
            end
        end
        local target_card = (my_pos and my_pos < #G.jokers.cards) and G.jokers.cards[my_pos + 1] or nil
                    return true
                end,
                    message = "+"..tostring(card.ability.extra.sell_value).." Sell Value",
                    extra = {
                        func = function()
                    card.ability.extra.ten = math.max(0, (card.ability.extra.ten) - 2)
                    return true
                end,
                        colour = G.C.RED
                        }
                }
            end
        end
    end
}