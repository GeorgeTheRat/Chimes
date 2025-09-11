SMODS.Joker{ --Chocolate Strawberry
    key = "chocolatestrawberry",
    config = {
        extra = {
            banana = 4
        }
    },
    loc_txt = {
        ['name'] = 'Chocolate Strawberry',
        ['text'] = {
            [1] = '{C:attention}+#1# {}{C:attention}Joker Slots{} while in a {C:attention}Blind{}{}',
            [2] = 'Decreases by {C:attention}1{} at end of round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_food"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.banana}}
    end,

    calculate = function(self, card, context)
        if context.setting_blind  and not context.blueprint then
            if (card.ability.extra.banana or 0) <= 0 then
                return {
                    func = function()
                card:undefined()
                return true
            end
                }
            else
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.banana).." Joker Slot", colour = G.C.DARK_EDITION})
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.banana
                return true
            end
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
                local banana_value = card.ability.extra.banana
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(banana_value).." Joker Slot", colour = G.C.RED})
                G.jokers.config.card_limit = math.max(1, G.jokers.config.card_limit - banana_value)
                return true
            end,
                    extra = {
                        func = function()
                    card.ability.extra.banana = math.max(0, (card.ability.extra.banana) - 1)
                    return true
                end,
                        colour = G.C.RED
                        }
                }
        end
        if context.selling_self  and not context.blueprint then
            if (G.GAME.blind:get_type() == 'Small' or G.GAME.blind:get_type() == 'Big' or G.GAME.blind.boss) then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.banana).." Joker Slot", colour = G.C.RED})
                G.jokers.config.card_limit = math.max(1, G.jokers.config.card_limit - card.ability.extra.banana)
                return true
            end
                }
            end
        end
    end
}