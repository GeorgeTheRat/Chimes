SMODS.Joker{ --Ghost Costume
    key = "ghostcostume",
    config = {
        extra = {
            edititionion = 1,
            odds = 13,
            dollars = 10,
            costumes1 = 0,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Ghost Costume',
        ['text'] = {
            [1] = 'Scored cards have a {C:green}#4# in #5# {}',
            [2] = 'chance of having {C:edition}Foil{}, {C:edition}Holographic{}, or {C:edition}Polychrome{} applied',
            [3] = '{C:red}-$10{} and create another {C:attention}Costume{} when sold'
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
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_costumes"] = true, ["solo_costumes2"] = true },

    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_solo_ghostcostume') 
        return {vars = {card.ability.extra.edititionion, card.ability.extra.costumes1, card.ability.extra.respect, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_422d6e71', 1, card.ability.extra.odds, 'j_solo_ghostcostume', false) then
              local random_edition = poll_edition('edit_card_edition', nil, true, true)
                if random_edition then
                    context.other_card:set_edition(random_edition, true)
                end
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.BLUE})
          end
            end
        end
        if context.selling_self  and not context.blueprint then
                return {
                    dollars = -card.ability.extra.dollars,
                    extra = {
                        func = function()
            local created_joker = false
    if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        created_joker = true
        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    local joker_card = SMODS.add_card({ set = 'solo_costumes1' })
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
        end,
                        colour = G.C.BLUE
                        }
                }
        end
    end
}