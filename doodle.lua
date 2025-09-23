SMODS.Enhancement {
    key = 'doodle',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            odds = 4,
            mult = 4,
            x_mult = 2,
            chips = 30,
            dollars = 3
        }
    },
    loc_txt = {
        name = 'Doodle',
        text = {
        [1] = '{C:green}#1# in #2#{} chance to give {C:red}+4{} Mult',
        [2] = '{C:green}#1# in #2#{} chance to give {C:blue}+30{} Chips',
        [3] = '{C:green}#1# in #2#{} chance to give {X:red,C:white}X2{} Mult',
        [4] = '{C:green}#1# in #2#{} chance to give {C:attention}+$3{}',
        [5] = ''
    }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 5,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'm_solo_doodle')
        return {vars = {numerator, denominator}}
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'group_0_40a45d4f', 1, card.ability.extra.odds, 'm_solo_doodle') then
                SMODS.calculate_effect({mult = card.ability.extra.mult}, card)
            end
            if SMODS.pseudorandom_probability(card, 'group_1_301a7a09', 1, card.ability.extra.odds, 'm_solo_doodle') then
                SMODS.calculate_effect({x_mult = card.ability.extra.x_mult}, card)
            end
            if SMODS.pseudorandom_probability(card, 'group_2_8df4a760', 1, card.ability.extra.odds, 'm_solo_doodle') then
                SMODS.calculate_effect({chips = card.ability.extra.chips}, card)
            end
            if SMODS.pseudorandom_probability(card, 'group_3_51890883', 1, card.ability.extra.odds, 'm_solo_doodle') then
                SMODS.calculate_effect({dollars = lenient_bignum(card.ability.extra.dollars)}, card)
            end
        end
    end
}