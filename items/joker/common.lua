SMODS.Joker{
    key = "bingo_card",
    name = "Bingo Card",
    config = {
        extra = {
            total_req = 5,
            blinds_defeated = 0,
            dollars = 40,
        }
    },
    pos = { x = 2, y = 0 },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.total_req,
                card.ability.extra.blinds_defeated,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if card.ability.extra.blinds_defeated + 1 >= card.ability.extra.total_req then
                card.ability.extra.blinds_defeated = 0
                return {
                    dollars = card.ability.extra.dollars,
                    extra = {
                        func = function()
                            local tag = Tag("tag_boss")
                            tag:set_ability()
                            add_tag(tag)
                            play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                            play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end
                    }
                }
            else
                card.ability.extra.blinds_defeated = card.ability.extra.blinds_defeated + 1
            end
        end
    end
}

SMODS.Joker{
    key = "figure_1",
    name = "Figure 1",
    pos = { x = 0, y = 1 },
    atlas = "joker",
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_literature
        return { vars = { } }
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_chm_literature") then
                return true
            end
        end
        return false
    end
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
        local function is_rank_not_in_hand(hand, rank_id)
            for _, card in ipairs(hand) do
                if card:get_id() == rank_id then
                    return false
                end
            end
            return true
        end
        local function update_target_card(target_key, seed_suffix)
            if not G.playing_cards then
                return
            end
            local valid_cards = {}
            for _, v in ipairs(G.playing_cards) do
                if not SMODS.has_no_rank(v) then
                    table.insert(valid_cards, v)
                end
            end
            if #valid_cards > 0 then
                local selected = pseudorandom_element(valid_cards, pseudoseed(seed_suffix .. G.GAME.round_resets.ante))
                G.GAME.current_round[target_key] = {
                    rank = selected.base.value,
                    id = selected.base.id
                }
            end
        end
        if context.joker_main and #context.full_hand >= 5 then
            local r1_missing = is_rank_not_in_hand(context.full_hand, G.GAME.current_round.r1_card.id)
            local r2_missing = is_rank_not_in_hand(context.full_hand, G.GAME.current_round.r2_card.id)
            if r1_missing and r2_missing and G.GAME.blind.in_blind then
                local cards_to_draw = card.ability.extra.card_draw
                SMODS.draw_cards(cards_to_draw)
                return {
                    message = string.format("+%d Cards Drawn", cards_to_draw)
                }
            end
        end
        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            update_target_card("r1_card", "r1")
            update_target_card("r2_card", "r2")
        end
    end
}

SMODS.Joker {
    key = "keychain",
    name = "Keychain",
    config = {
        extra = {
            tags = 1,
            tags_mod = 1,
            toggle = 1
        }
    },
    pos = { x = 6, y = 1 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.tags,
                card.ability.extra.tags_mod
            }
        }
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
            return {
                message = "+" .. card.ability.extra.tags .. " Tag" .. (card.ability.extra.tags > 1 and "s" or ""),
                colour = G.C.BLUE
            }
        end
        if card.ability.extra.toggle == 1 and context.tag_added and not context.blueprint then
            card.ability.extra.tags = card.ability.extra.tags + card.ability.extra.tags_mod
            return {
                message = "+" .. card.ability.extra.tags_mod .. " Tag" .. (card.ability.extra.tags_mod > 1 and "s" or ""),
                colour = G.C.BLUE
            }
        end
    end
}

SMODS.Joker {
    key = "makisu",
    name = "Makisu",
    pos = { x = 9, y = 1 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    calculate = function(self, card, context)
        if context.using_consumeable and G.GAME.blind.boss then
            local created_joker = false
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                created_joker = true
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local joker_card = SMODS.add_card({ set = "sushi" })
                        if joker_card then
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end
                }))
            end
            if created_joker then
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.BLUE
                }
            end
        end
    end
}

SMODS.Joker {
    key = "onigiri",
    name = "Onigiri",
    config = {
        extra = {
            chips = 75,
            chips_mod = 15,
            voucher_slots = 1
        }
    },
    pos = { x = 2, y = 2 },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_mod,
                card.ability.extra.voucher_slots
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.pre_discard and not context.blueprint then
            if (card.ability.extra.chips - card.ability.extra.chips_mod) >= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                card.ability.extra.chips = math.max(0, card.ability.extra.chips - card.ability.extra.chips_mod)
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_voucher_limit(card.ability.extra.voucher_slots)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_voucher_limit(-card.ability.extra.voucher_slots)
    end
}

SMODS.Joker {
    key = "punk",
    name = "Punk Joker",
    config = {
        extra = {
            chip_mod = 20,
            chips = 0
        }
    },
    pos = { x = 8, y = 2 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chip_mod,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and context.removed then
            local spade_or_club_count = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card:is_suit("Spades") or removed_card:is_suit("Clubs") then
                    spade_or_club_count = spade_or_club_count + 1
                end
            end
            if spade_or_club_count > 0 then
                card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * spade_or_club_count)
                return {
                    message = "Upgrade!",
                    colour = G.C.BLUE
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker {
    key = "rotten",
    name = "Rotten Joker",
    config = {
        extra = {
            xmult = 0.75,
            dollars = 6
        }
    },
    pos = { x = 0, y = 3 },
    cost = 6,
    rarity = 1,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_rotten
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.dollars
            }
        }
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_chm_rotten") then
                return true
            end
        end
        return false
    end
}

SMODS.Joker {
    key = "salmon_nigiri",
    name = "Salmon Nigiri",
    config = {
        extra = {
            mult = 12,
            mult_mod = 1,
            h_mult_mod = 1,
        }
    },
    pos = { x = 1, y = 3 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    pools = { ["sushi"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_mod,
                card.ability.extra.h_mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.after and card.ability.extra.mult - card.ability.extra.mult_mod <= 0 then
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = localize("k_eaten_ex")
            }
        end
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_h_mult = context.other_card.ability.perma_h_mult + card.ability.extra.h_mult_mod
            card.ability.extra.mult = math.max(0, (card.ability.extra.mult) - 1)
            return {
                extra = {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.MULT
                },
                card = card
            }
        end
    end
}

SMODS.Joker {
    key = "tamago",
    name = "Tamago",
    config = {
        extra = {
            dollars = 10,
            dollars_mod = 2,
            sell_value_mod = 4,
        }
    },
    pos = { x = 5, y = 3 },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    pools = { ["sushi"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.dollars_mod,
                card.ability.extra.sell_value_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            ease_dollars(card.ability.extra.dollars)
        end
        if context.skip_blind then
            if card.ability.extra.dollars - card.ability.extra.dollars_mod <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            else
                local pos = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        pos = i
                        break
                    end
                end
                local target_card = (pos and pos < #G.jokers.cards) and G.jokers.cards[pos + 1] or nil
                if target_card then
                    target_card.ability.extra_value = (target_card.ability.extra_value or 0) + card.ability.extra.sell_value_mod
                    target_card:set_cost()
                    card.ability.extra.dollars = math.max(0, card.ability.extra.dollars - card.ability.extra.dollars_mod)
                    return {
                        message = "Value Up!",
                        colour = G.C.MONEY,
                    }
                else
                    card.ability.extra.dollars = math.max(0, card.ability.extra.dollars - card.ability.extra.dollars_mod)
                end
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

SMODS.Joker {
    key = "trickster",
    name = "Trickster",
    config = { extra = { shop_size = 1 } },
    pos = { x = 1, y = 4 },
    cost = 4,
    rarity = 1,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.shop_size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(-card.ability.extra.shop_size)
                return true
            end
        }))
    end
}