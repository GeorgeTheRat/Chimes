SMODS.Joker {
    key = "handroll",
    config = {
        extra = {
            all = 4,
            handys = 0,
            handsremaining = 0,
            round = 0,
            start_dissolve = 0,
            y = 0
        }
    },
    pos = { x = 5, y = 1 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.all }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            return {
                func = function()
                    card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                        message = "+" .. tostring(card.ability.extra.all) .. " Hand",
                        colour = G.C.GREEN
                    })
                    G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.all
                    return true
                end
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if (card.ability.extra.all or 0) <= 0 then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                    end,
                    message = "Eaten!"
                }
            else
                local handys_value = card.ability.extra.handys
                return {
                    func = function()
                        card.ability.extra.handys = G.GAME.current_round.hands_left
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.handys = (card.ability.extra.handys) * 4
                            return true
                        end,
                        colour = G.C.MULT,
                        extra = {
                            dollars = handys_value,
                            colour = G.C.MONEY,
                            extra = {
                                func = function()
                                    card.ability.extra.all = math.max(0, (card.ability.extra.all) - 1)
                                    return true
                                end,
                                colour = G.C.RED
                            }
                        }
                    }
                }
            end
        end
    end
}
