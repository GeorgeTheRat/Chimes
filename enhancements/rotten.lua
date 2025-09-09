SMODS.Enhancement {
    key = 'rotten',
    pos = { x = 6, y = 0 },
    config = {
        extra = {
            x_mult = 1.75,
            dollars = 3
        }
    },
    loc_txt = {
        name = 'Rotten',
        text = {
        [1] = '{X:red,C:white}X1.75{} Mult',
        [2] = '{C:red}-$3{} when scored'
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
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return { x_mult = card.ability.extra.x_mult, dollars = -lenient_bignum(card.ability.extra.dollars) }
        end
    end
}