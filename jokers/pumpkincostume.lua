SMODS.Joker{ --Pumpkin Costume
    key = "pumpkincostume",
    config = {
        extra = {
            edititionion = 1,
            odds = 2,
            odds2 = 2,
            dollars = 10,
            costumes = 0,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Pumpkin Costume',
        ['text'] = {
            [1] = 'Scored cards have a {C:green}#4# in #5# {}chance',
            [2] = 'of being {C:red}destroyed{} and a {C:green}#4# in #5# {}',
            [3] = 'chance of having a random {C:attention}Seal{} applied',
            [4] = '{C:red}-$10{} and create another {C:attention}Costume{} when sold'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 3
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
    pools = { ["solo_costumes1"] = true, ["solo_costumes2"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_solo_pumpkincostume') 
        return {vars = {card.ability.extra.edititionion, card.ability.extra.costumes, card.ability.extra.respect, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_94b68a9b', 1, card.ability.extra.odds, 'j_solo_pumpkincostume', false) then
              local random_seal = SMODS.poll_seal({mod = 10, guaranteed = true})
                if random_seal then
                    context.other_card:set_seal(random_seal, true)
                end
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.BLUE})
          end
            elseif true then
                if SMODS.pseudorandom_probability(card, 'group_0_b7f55f3a', 1, card.ability.extra.odds, 'j_solo_pumpkincostume', false) then
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
                    local joker_card = SMODS.add_card({ set = 'solo_costumes' })
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