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