SMODS.Joker{
    key = "bingo_card",
    name = "Bingo Card",
    config = {
        extra = {
            eyes = 0,
            dollars = 30,
            var1 = 0
        }
    },
    pos = { x = 2, y = 0 },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.eyes } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            if (card.ability.extra.eyes or 0) == 5 then
                return {
                    dollars = card.ability.extra.dollars,
                    extra = {
                        func = function()
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
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
                    return true
                end,
                            message = "Created Tag!",
                        colour = G.C.GREEN,
                        extra = {
                            func = function()
                    card.ability.extra.eyes = 0
                    return true
                end,
                            colour = G.C.BLUE
                        }
                        }
                }
            else
                return {
                    func = function()
                    card.ability.extra.var1 = (card.ability.extra.var1) + 1
                    return true
                end
                }
            end
        end
    end
}

SMODS.Joker{
    key = "figure1",
    pos = { x = 0, y = 1 },
    atlas = "joker",
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_literature
        return { vars = { } }
    end,
}

SMODS.Joker {
    key = "go_fish",
    name = "Go Fish",
    config = { extra = { card_draw = 6 } },
    pos = { x = 4, y = 1 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize((G.GAME.current_round.r1_card or {}).rank or "Ace", "ranks"),
                localize((G.GAME.current_round.r2_card or {}).rank or "Ace", "ranks")
            }
        }
    end,
    set_ability = function(self, card, initial)
        G.GAME.current_round.r1_card = {
            rank = "Ace",
            id = 14
        }
        G.GAME.current_round.r2_card = {
            rank = "King",
            id = 13
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            if (#context.full_hand >= 5 and (function()
                local rankFound = true
                for i, c in ipairs(context.full_hand) do
                    if c:get_id() == G.GAME.current_round.r1_card.id then
                        rankFound = false
                        break
                    end
                end

                return rankFound
            end)() and (function()
                local rankFound = true
                for i, c in ipairs(context.full_hand) do
                    if c:get_id() == G.GAME.current_round.r2_card.id then
                        rankFound = false
                        break
                    end
                end

                return rankFound
            end)()) then
                if G.GAME.blind.in_blind then
                    SMODS.draw_cards(card.ability.extra.card_draw)
                end
                return {
                    message = "+" .. tostring(card.ability.extra.card_draw) .. " Cards Drawn"
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.playing_cards then
                local valid_r1_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_rank(v) then
                        valid_r1_cards[#valid_r1_cards + 1] = v
                    end
                end
                if valid_r1_cards[1] then
                    local r1_card = pseudorandom_element(valid_r1_cards, pseudoseed("r1" .. G.GAME.round_resets.ante))
                    G.GAME.current_round.r1_card.rank = r1_card.base.value
                    G.GAME.current_round.r1_card.id = r1_card.base.id
                end
            end
            if G.playing_cards then
                local valid_r2_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_rank(v) then
                        valid_r2_cards[#valid_r2_cards + 1] = v
                    end
                end
                if valid_r2_cards[1] then
                    local r2_card = pseudorandom_element(valid_r2_cards, pseudoseed("r2" .. G.GAME.round_resets.ante))
                    G.GAME.current_round.r2_card.rank = r2_card.base.value
                    G.GAME.current_round.r2_card.id = r2_card.base.id
                end
            end
        end
    end
}

SMODS.Joker {
    key = "keychain",
    name = "Keychain",
    config = { extra = { tags = 1, tags_mod = 1, toggle = 1 } },
    pos = { x = 6, y = 1 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.tags, card.ability.extra.tags_mod } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            card.ability.extra.toggle = 0
            for i = 1, card.ability.extra.tags do
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
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "j_chm_keychain")
                        end
                        tag:set_ability()
                        add_tag(tag)
                        play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
            end
            if card.ability.extra.tags == 1 then
                return {
                    message = "+" .. card.ability.extra.tags .. " Tag",
                    colour = G.C.BLUE
                }
            else
                return {
                    message = "+" .. card.ability.extra.tags .. " Tags",
                    colour = G.C.BLUE
                }
            end
        end
        if card.ability.extra.toggle == 1 and context.tag_added and not context.blueprint then
            card.ability.extra.tags = card.ability.extra.tags + card.ability.extra.tags_mod
            if card.ability.extra.tags_mod == 1 then
                return {
                    message = "+" .. card.ability.extra.tags_mod .. " Tag",
                    colour = G.C.BLUE
                }
            else
                return {
                    message = "+" .. card.ability.extra.tags_mod .. " Tags",
                    colour = G.C.BLUE
                }
            end
        end
    end
}

--[[
SMODS.Joker{
    key = "koi",
    name = "Koi",
    config = { extra = { } },
    pos = { x = 7, y = 1 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    pools = { ["chm_chm_jokers"] = true }
}
]]

SMODS.Joker {
    key = "makisu",
    name = "Makisu",
    pos = { x = 9, y = 1 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.using_consumeable then
            if G.GAME.blind.boss then
                return {
                    func = function()
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({
                                        set = "chmsushi"
                                    })
                                    if joker_card then
                                        G.GAME.joker_buffer = 0
                                    end
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
                }
            end
        end
    end
}

SMODS.Joker{
    key = "train_ticket",
    name = "Train Ticket",
    config = { extra = { discards = 2 } },
    pos = { x = 0, y = 4 },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards } }
    end,
    calculate = function(self, card, context)
        if context.before then
            if G.GAME.current_round.hands_played == 2 then
                ease_discard(card.ability.extra.discards)
                return {
                    message = "+" .. card.ability.extra.discards .. " Discards",
                    colour = G.C.RED
                }
            end
        end
    end
}