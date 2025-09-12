SMODS.Joker{ --Keychain
    key = "keychain",
    config = {
        extra = {
            aaa = 8,
            currenthandsize = 0,
            odds = "card.ability.extra.aaa"
        }
    },
    loc_txt = {
        ['name'] = 'Keychain',
        ['text'] = {
            [1] = 'When a discard is used, {C:green}#3# in #1# {}',
            [2] = 'chance of creating a random {C:attention}Tag{}, chance',
            [3] = '{C:attention}increases{} with {C:red}decreased{}{C:attention} hand size{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_solo_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_solo_keychain') 
        return {vars = {card.ability.extra.aaa, ((G.hand and G.hand.config.card_limit or 0) or 0), new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.pre_discard  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_b7cfff6c', 1, card.ability.extra.odds, 'j_solo_keychain', false) then
              SMODS.calculate_effect({func = function()
            G.E_MANAGER:add_event(Event({
                func = function()
                    local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                    local tag = Tag(selected_tag)
                    if tag.name == "Orbital Tag" then
                        local _poker_hands = {}
                        for k, v in pairs(G.GAME.hands) do
                            if v.visible then
                                _poker_hands[#_poker_hands + 1] = k
                            end
                        end
                        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                    end
                    tag:set_ability()
                    add_tag(tag)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
                    return true
                end}, card)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Created Tag!", colour = G.C.GREEN})
          end
            end
        end
        if context.setting_blind  then
                return {
                    func = function()
                    card.ability.extra.aaa = (card.ability.extra.aaa) + (G.hand and G.hand.config.card_limit or 0)
                    return true
                end
                }
        end
    end
}