SMODS.Joker{ --Orchid
    key = "orchid",
    config = {
        extra = {
            odds = 10
        }
    },
    loc_txt = {
        ['name'] = 'Orchid',
        ['text'] = {
            [1] = 'Each {C:spades}Spade{} card held in hand',
            [2] = 'has a {C:green}1 in 10 {}chance to create',
            [3] = 'a random {C:spectral}Spectral{} Card'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if context.other_card:is_suit("Spades") then
                if SMODS.pseudorandom_probability(card, 'group_0_9630fc7a', 1, card.ability.extra.odds, 'j_solo_orchid', false) then
              SMODS.calculate_effect({
    func = function()
    for i = 1, math.min(undefined, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
            play_sound('timpani')
            SMODS.add_card({ set = 'Spectral', soulable = true, })                            
            card:juice_up(0.3, 0.5)
            return true
        end
        }))
    end
    delay(0.6)

                    if created_consumable then
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                    end
                    return true
                  end}, card)
          end
            end
        end
    end
}