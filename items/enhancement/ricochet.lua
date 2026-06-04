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
        local function increment_counters()
            card.ability.extra.chip_counter = card.ability.extra.chip_counter + 1
            card.ability.extra.mult_counter = card.ability.extra.mult_counter + 1
            card.ability.extra.dollars_counter = card.ability.extra.dollars_counter + 1
            card.ability.extra.xmult_counter = card.ability.extra.xmult_counter + 1
        end
        if (context.discard and context.other_card == card) or (next(SMODS.find_card("j_chm_wallbang")) and context.main_scoring and context.cardarea == G.hand) then
            local counters = {
                "chip",
                "mult",
                "dollars",
                "xmult"
            }
            for _, counter_type in ipairs(counters) do
                local counter_key = counter_type .. "_counter"
                local trigger_key = counter_type .. "_trigger"
                if card.ability.extra[counter_key] >= card.ability.extra[trigger_key] then
                    card.ability.extra[counter_key] = 0
                end
            end
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