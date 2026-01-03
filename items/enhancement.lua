SMODS.Enhancement {
    key = "doodle",
    name = "Doodle",
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            chips_odds = 4,
            chips = 30,
            mult_odds = 4,
            mult = 4,
            xmult_odds = 4,
            xmult = 2,
            dollars_odds = 4,
            dollars = 3
        }
    },
    atlas = "enhancement",
    weight = 5,
    loc_vars = function(self, info_queue, card)
        local chips_numerator, chips_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chips_odds, "m_chm_doodle")
        local mult_numerator, mult_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.mult_odds, "m_chm_doodle")
        local xmult_numerator, xmult_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.xmult_odds, "m_chm_doodle")
        local dollars_numerator, dollars_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.dollars_odds, "m_chm_doodle")
        return {
            vars = { 
                chips_numerator,
                chips_denominator,
                card.ability.extra.chips,
                mult_numerator,
                mult_denominator,
                card.ability.extra.mult,
                xmult_numerator,
                xmult_denominator,
                card.ability.extra.xmult,
                dollars_numerator,
                dollars_denominator,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, "c_chm_doodle", 1, card.ability.extra.chips_odds) then
                return {
                    mult = card.ability.extra.mult
                }
            end
            if SMODS.pseudorandom_probability(card, "c_chm_doodle", 1, card.ability.extra.mult_odds) then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
            if SMODS.pseudorandom_probability(card, "c_chm_doodle", 1, card.ability.extra.xmult_odds) then
                return {
                    chips = card.ability.extra.chips
                }
            end
            if SMODS.pseudorandom_probability(card, "c_chm_doodle", 1, card.ability.extra.dollars_odds) then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end
}

SMODS.Enhancement {
    key = "literature",
    name = "Literature",
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            chips = 20,
            chips_mod = 10
        }
    },
    atlas = "enhancement",
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chips_mod
            }
        }
    end, 
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.main_scoring then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.discard and context.other_card == card then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {
                message = "Upgrade!",
                colour = G.C.CHIPS
            }
        end
        if context.main_scoring and context.cardarea == G.play then
            if next(SMODS.find_card("j_chm_figure_1")) then
                return { 
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

SMODS.Enhancement {
    key = "mechanical",
    name = "Mechanical",
    pos = { x = 2, y = 0 },
    config = {
        x_mult = 1,
        extra = {
            x_mult_mod = 0.5
        }
    },
    atlas = "enhancement",
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.x_mult,
                card.ability.extra.x_mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            card.ability.x_mult = card.ability.x_mult + card.ability.extra.x_mult_mod
            return {
                message = "Upgrade!",
                colour = G.C.RED
            }
        end
        if context.after and context.cardarea == G.play and card.ability.x_mult ~= 1 then
            card.ability.x_mult = 1
            return {
                message = "Reset!",
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
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            local target_hand
            local available_hands = {}
            for hand, value in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(hand) then
                    table.insert(available_hands, hand)
                end
            end
            target_hand = #available_hands > 0 and pseudorandom_element(available_hands, pseudoseed("m_chm_old")) or "High Card"
            SMODS.calculate_effect({
                level_up = card.ability.extra.levels,
                level_up_hand = target_hand 
            }, card)
        end
    end
}

SMODS.Enhancement {
    key = "overgrown",
    name = "Overgrown",
    pos = { x = 4, y = 0 },
    config = { chips = 5 },
    atlas = "enhancement",
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.chips } }
    end
}

SMODS.Enhancement {
    key = "ricochet",
    name = "Ricochet",
    pos = { x = 5, y = 0 },
    config = {
        extra = {
            chips = 120,
            chip_trigger = 3,
            chip_counter = 0,
            mult = 30,
            mult_trigger = 4,
            mult_counter = 0,
            dollars = 10,
            dollars_trigger = 5,
            dollars_counter = 0,
            xmult = 2,
            xmult_trigger = 6,
            xmult_counter = 0
        } 
    },
    atlas = "enhancement",
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chip_trigger,
                card.ability.extra.chip_counter,
                card.ability.extra.mult,
                card.ability.extra.mult_trigger,
                card.ability.extra.mult_counter,
                card.ability.extra.dollars,
                card.ability.extra.dollars_trigger,
                card.ability.extra.dollars_counter,
                card.ability.extra.xmult,
                card.ability.extra.xmult_trigger,
                card.ability.extra.xmult_counter
            }
        }
    end,
    calculate = function(self, card, context)
        -- reset counters that have reached their triggers
        local function reset_counters()
            local counters = { "chip", "mult", "dollars", "xmult" }
            for _, counter_type in ipairs(counters) do
                local counter_key = counter_type .. "_counter"
                local trigger_key = counter_type .. "_trigger"
                if card.ability.extra[counter_key] >= card.ability.extra[trigger_key] then
                    card.ability.extra[counter_key] = 0
                end
            end
        end
        -- increment all counters
        local function increment_counters()
            card.ability.extra.chip_counter = card.ability.extra.chip_counter + 1
            card.ability.extra.mult_counter = card.ability.extra.mult_counter + 1
            card.ability.extra.dollars_counter = card.ability.extra.dollars_counter + 1
            card.ability.extra.xmult_counter = card.ability.extra.xmult_counter + 1
        end
        -- on discard or held in hand if wallbang joker is owned reset (if applicable) and increment counters
        if (context.discard and context.other_card == card) or (SMODS.find_card("j_chm_richochet") and context.main_scoring and context.cardarea == G.hand) then
            reset_counters()
            increment_counters()
            if (card.ability.extra.dollars_counter + 1) >= card.ability.extra.dollars_trigger then
                ease_dollars(card.ability.extra.dollars)
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = "$" .. card.ability.extra.dollars,
                    colour = G.C.MONEY
                })
            end
            card_eval_status_text(card, "extra", nil, nil, nil, {
                message = "Upgrade!"
            })
        end
        -- main scoring to increment counters
        if context.main_scoring and context.cardarea == G.play then
            increment_counters()
            local ret = {}
            if card.ability.extra.chip_counter >= card.ability.extra.chip_trigger then
                card.ability.extra.chip_counter = 0
                ret.chips = card.ability.extra.chips
            end
            if card.ability.extra.mult_counter >= card.ability.extra.mult_trigger then
                card.ability.extra.mult_counter = 0
                ret.mult = card.ability.extra.mult
            end
            if card.ability.extra.dollars_counter >= card.ability.extra.dollars_trigger then
                card.ability.extra.dollars_counter = 0
                ret.dollars = card.ability.extra.dollars
            end
            if card.ability.extra.xmult_counter >= card.ability.extra.xmult_trigger then
                card.ability.extra.xmult_counter = 0
                ret.xmult = card.ability.extra.xmult
            end
            -- return all triggered effects
            if next(ret) then
                return ret
            end
        end
    end
}

SMODS.Enhancement {
    key = "rotten",
    name = "Rotten",
    pos = { x = 6, y = 0 },
    config = {
        extra = {
            xmult = 1.75,
            dollars = 3
        }
    },
    atlas = "enhancement",
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local rotten_joker = SMODS.find_card("j_chm_rotten")[1]
            if rotten_joker then
                return {
                    xmult = rotten_joker.ability.extra.xmult,
                    dollars = rotten_joker.ability.extra.dollars
                }
            else
                return {
                    xmult = card.ability.extra.xmult,
                    dollars = -card.ability.extra.dollars
                }
            end
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
    weight = 3,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_overgrown
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
            local overgrown_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == "j_chm_overgrown" then
                    overgrown_count = overgrown_count + 1
                end
            end
            local current_odds = card.ability.extra.odds * (2 ^ overgrown_count)
            if SMODS.pseudorandom_probability(card, "m_chm_vine", 1, current_odds) then
                card:set_ability(G.P_CENTERS.m_chm_overgrown)
                return {
                    message = "Card Modified!",
                    colour = G.C.BLUE
                }
            end
        end
    end,
    update = function(self, card, dtt)
        card.ability.extra.freeconsumableslots = (G.consumeables and G.consumeables.config.card_limit or 0) - #(G.consumeables and G.consumeables.cards or {})
    end
}