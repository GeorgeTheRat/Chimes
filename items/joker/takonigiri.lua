SMODS.Joker {
    key = "takonigiri",
    name = "Tako Nigiri",
    config = {
        extra = {
            numby = 6,
            freejokerslots = 1,
            respect = 0
        }
    },
    pos = { x = 4, y = 3 },
    cost = 8,
    rarity = 3,
    eternal_compat = false,
    atlas = "joker",
    pools = {
        ["chm_sushi"] = true
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.numby}
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            if card.ability.extra.numby <= card.ability.extra.freejokerslots + (((G.jokers and G.jokers.config.card_limit or 0) - #(G.jokers and G.jokers.cards or {}))) then
                for i = 1, card.ability.extra.numby do
                    local created_joker = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({
                                set = "Joker",
                                rarity = "Rare"
                            })
                            if joker_card then
                            end
                            return true
                        end
                    }))
                    if created_joker then
                        card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                            message = localize("k_plus_joker"),
                            colour = G.C.BLUE
                        })
                    end
                    return true
                end
            elseif card.ability.extra.numby <= 0 then
                local created_joker = false
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    created_joker = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({
                                set = "Joker",
                                rarity = "Legendary"
                            })
                            if joker_card then
                            end
                            G.GAME.joker_buffer = 0
                            return true
                        end
                    }))
                end
                if created_joker then
                    card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
                        message = localize("k_plus_joker"),
                        colour = G.C.BLUE
                    })
                end
                return true
            end
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss and not context.blueprint then
            if (card.ability.extra.numby or 0) ~= 0 then
                card.ability.extra.numby = math.max(0, (card.ability.extra.numby) - 1)
            end
        end
    end
}