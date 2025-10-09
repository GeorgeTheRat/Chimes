SMODS.Enhancement {
    key = "doodle",
    name = "Doodle",
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            odds = 4,
            mult = 4,
            xmult = 2,
            chips = 30,
            dollars = 3
        }
    },
    atlas = "enhancement",
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    weight = 5,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "m_chm_oodle")
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, "group_0_40a45d4f", 1, card.ability.extra.odds, "m_chm_oodle") then
                SMODS.calculate_effect({mult = card.ability.extra.mult}, card)
            end
            if SMODS.pseudorandom_probability(card, "group_1_301a7a09", 1, card.ability.extra.odds, "m_chm_oodle") then
                SMODS.calculate_effect({xmult = card.ability.extra.xmult}, card)
            end
            if SMODS.pseudorandom_probability(card, "group_2_8df4a760", 1, card.ability.extra.odds, "m_chm_oodle") then
                SMODS.calculate_effect({chips = card.ability.extra.chips}, card)
            end
            if SMODS.pseudorandom_probability(card, "group_3_51890883", 1, card.ability.extra.odds, "m_chm_oodle") then
                SMODS.calculate_effect({dollars = lenient_bignum(card.ability.extra.dollars)}, card)
            end
        end
    end
}

SMODS.Enhancement {
    key = "literature",
    name = "Literature",
    pos = { x = 1, y = 0 },
    config = { extra = { chips = 20, chips_mod = 20 } },
    atlas = "enhancement",
    any_suit = false,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_mod } }
    end, 
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.main_scoring then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.discard and context.other_card == card then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
        end
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == "j_chm_figure1" then
                    return { 
                        chips = card.ability.extra.chips
                    }
                end
            end
        end
    end
}

SMODS.Enhancement {
    key = "mechanical",
    name = "Mechanical",
    pos = { x = 2, y = 0 },
    config = {
        extra = {
            xmult_mod = 0.4,
            xmult_mod_2 = 0.05,
            xmult = 1.5
        }
    },
    atlas = "enhancement",
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult_mod_2, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            card.ability.extra.xmult = math.max(1, (card.ability.extra.xmult) - card.ability.extra.xmult_mod_2)
            return {
                message = "Downgrade!",
                colour = G.C.RED
            }
        end
        if context.end_of_round and context.cardarea == G.hand and context.other_card == card and context.individual then
            card.ability.extra.xmult = (card.ability.extra.xmult) + card.ability.extra.xmult_mod
            return {
                message = "Upgrade!",
                colour = G.C.RED
            }
        end
    end
}

SMODS.Enhancement {
    key = "old",
    name = "Old",
    pos = { x = 3, y = 0 },
    config = { extra = { levels = 2 } },
    atlas = "enhancement",
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    weight = 5,
    calculate = function(self, card, context)
        if context.discard then
            local target_hand
                local available_hands = {}
                for hand, value in pairs(G.GAME.hands) do
                    if value.visible and value.level >= to_big(1) then
                        table.insert(available_hands, hand)
                    end
                end
                target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed("level_up_hand_enhanced")) or "High Card"
            return {
                level_up = card.ability.extra.levels,
                level_up_hand = target_hand
            }
        end
    end
}

SMODS.Enhancement {
    key = "overgrown",
    name = "Overgrown",
    pos = { x = 4, y = 0 },
    config = { chips = 5 },
    atlas = "enhancement",
    any_suit = false,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    weight = 0,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.hand then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

SMODS.Enhancement {
    key = "polished",
    name = "Polished",
    pos = { x = 5, y = 0 },
    config = { extra = { card_draw = 2 } },
    atlas = "enhancement",
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.card_draw } }
    end,
    calculate = function(self, card, context)
        if context.discard then
            if G.GAME.blind.in_blind then
                SMODS.draw_cards(card.ability.extra.card_draw)
            end
            return {
                message = "+" .. tostring(card.ability.extra.card_draw) .. " Cards Drawn",
                colour = G.C.BLUE
            }
        end
    end
}

SMODS.Enhancement {
    key = "rotten",
    name = "Rotten",
    pos = { x = 6, y = 0 },
    config = {
        extra = {
            x_mult = 1.75,
            dollars = 3
        }
    },
    atlas = "enhancement",
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    weight = 5,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                xmult = card.ability.extra.x_mult,
                dollars = -lenient_bignum(card.ability.extra.dollars)
            }
        end
    end
}

SMODS.Enhancement {
    key = "vine",
    name = "Vine",
    pos = { x = 7, y = 0 },
    config = {
        extra = {
            freeconsumableslots = 0,
            odds = 20
        }
    },
    atlas = "enhancement",
    any_suit = false,
    replace_base_card = false,
    no_rank = true,
    no_suit = true,
    always_scores = false,
    weight = 3,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "m_chm_vine")
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.repetition then
            return {
                repetitions = card.ability.extra.freeconsumableslots
            }
        end
        if context.main_scoring and context.cardarea == G.play then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == "j_chm_overgrownjoker" then
                    card.ability.extra.odds = 40
                else
                    card.ability.extra.odds = 20
                end
            end
            if SMODS.pseudorandom_probability(card, "m_chm_vine", 1, card.ability.extra.odds) then
                card:set_ability(G.P_CENTERS.m_chm_overgrown)
                return {
                    message = "Card Modified!",
                    colour = G.C.BLUE
                }
            end
        end
    end,
    update = function(self, card, dtt)
        card.ability.extra.freeconsumableslots = (G.consumeables and G.consumeables.config.card_limit or 0 - #(G.consumeables and G.consumeables.cards or {}))
    end
}