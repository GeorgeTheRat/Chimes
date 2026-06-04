SMODS.Joker {
    key = "california_roll",
    name = "California Roll",
    config = {
        extra = {
            create = 5,
            decrease = 1
        }
    },
    pos = { x = 5, y = 0 },
    cost = 6,
    rarity = 2,
    eternal_compat = false,
    atlas = "joker",
    pools = { ["sushi"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.create,
                card.ability.extra.decrease
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            for i = 1, math.ceil(card.ability.extra.create) do
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if #G.jokers.cards < G.jokers.config.card_limit then
                                SMODS.add_card({ set = "Joker" })
                            end
                            G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                            return true
                        end
                    }))
                end
            end
            for i = 1, math.ceil(card.ability.extra.create) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            play_sound("timpani")
                            local forced_key = Chimes.random_consumable("california_roll", nil, "j_chm_california_roll")
                            local _card = create_card("Consumeables", G.consumeables, nil, nil, nil, nil, forced_key.config.center_key, "california_roll")
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                        end
                        return true
                    end,
                }))
            end
        end
        if context.playing_card_added then
            if card.ability.extra.create - card.ability.extra.decrease <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "create",
                    scalar_value = "create_mod",
                    operation = "-",
                    scaling_message = {
                        message = "-" .. tostring(card.ability.extra.create_mod)
                    }
                })
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local tag = Tag(pseudorandom_element(G.P_TAGS, pseudoseed("j_chm_california_roll")).key)
                        if tag.name == "Orbital Tag" then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then
                                    _poker_hands[#_poker_hands + 1] = k
                                end
                            end
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "j_chm_california_roll")
                        end
                        tag:set_ability()
                        add_tag(tag)
                        play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if #G.jokers.cards < G.jokers.config.card_limit then
                                SMODS.add_card({ set = "Joker" })
                            end
                            G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                            return true
                        end
                    }))
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            play_sound("timpani")
                            local forced_key = Chimes.random_consumable("california_roll", nil, "j_chm_california_roll")
                            local _card = create_card("Consumeables", G.consumeables, nil, nil, nil, nil, forced_key.config.center_key, "california_roll")
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                        end
                        return true
                    end,
                }))
            end
        end
    end
}