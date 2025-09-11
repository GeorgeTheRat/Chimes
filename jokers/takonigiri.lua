SMODS.Joker{ --Tako Nigiri
    key = "takonigiri",
    config = {
        extra = {
            numby = 6,
            freejokerslots = 1,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Tako Nigiri',
        ['text'] = {
            [1] = 'Sell this {C:attention}Joker{} to create {C:attention}#1# {}{C:rare}Rare{} {C:attention}Jokers{}',
            [2] = 'if there is space for {C:attention}all{} of them',
            [3] = 'Decreases by {C:attention}1{} at when a {C:attention}Boss Blind{} is defeated',
            [4] = 'At {C:attention}0{} create a random {C:legendary}Legendary{} {C:attention}Joker{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_sushi"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.numby}}
    end,

    calculate = function(self, card, context)
        if context.selling_self  then
            if card.ability.extra.numby <= card.ability.extra.freejokerslots + (((G.jokers and G.jokers.config.card_limit or 0) - #(G.jokers and G.jokers.cards or {}))) then
                for i = 1, card.ability.extra.numby do
              SMODS.calculate_effect({func = function()
            local created_joker = false
    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        created_joker = true
        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker' })
                    if joker_card then
                        
                        
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            end
            if created_joker then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
            end
            return true
        end}, card)
          end
            elseif card.ability.extra.numby <= 0 then
                return {
                    func = function()
            local created_joker = false
    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        created_joker = true
        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'Joker', rarity = 'Legendary' })
                    if joker_card then
                        
                        
                    end
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            end
            if created_joker then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
            end
            return true
        end
                }
            end
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
            if (card.ability.extra.numby or 0) ~= 0 then
                return {
                    func = function()
                    card.ability.extra.numby = math.max(0, (card.ability.extra.numby) - 1)
                    return true
                end
                }
            end
        end
    end
}