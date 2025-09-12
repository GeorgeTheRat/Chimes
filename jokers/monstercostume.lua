SMODS.Joker{ --Monster Costume
    key = "monstercostume",
    config = {
        extra = {
            edititionion = 1,
            odds = 2,
            odds2 = 2,
            dollars = 10,
            costumes2 = 0,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Monster Costume',
        ['text'] = {
            [1] = 'Scored cards have a {C:green}#4# in #5# {}chance',
            [2] = 'of being {C:red}destroyed{} and a {C:green}#4# in #5# {}',
            [3] = 'chance of having a random {C:attention}Enhancement{} applied',
            [4] = '{C:red}-$10{} and create another {C:attention}Costume{} when sold'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
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
    pools = { ["solo_costumes"] = true, ["solo_costumes1"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_solo_monstercostume') 
        return {vars = {card.ability.extra.edititionion, card.ability.extra.costumes2, card.ability.extra.respect, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_94b68a9b', 1, card.ability.extra.odds, 'j_solo_monstercostume', false) then
              local enhancement_pool = {}
                for _, enhancement in pairs(G.P_CENTER_POOLS.Enhanced) do
                    if enhancement.key ~= 'm_stone' then
                        enhancement_pool[#enhancement_pool + 1] = enhancement
                    end
                end
                local random_enhancement = pseudorandom_element(enhancement_pool, 'edit_card_enhancement')
                context.other_card:set_ability(random_enhancement)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.BLUE})
          end
            elseif true then
                if SMODS.pseudorandom_probability(card, 'group_0_b7f55f3a', 1, card.ability.extra.odds, 'j_solo_monstercostume', false) then
              context.other_card.should_destroy = true
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
          end
            end
        end
        if context.selling_self  then
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
                    local joker_card = SMODS.add_card({ set = 'solo_costumes2' })
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