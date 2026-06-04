SMODS.Joker{
    key = "brain",
    name = "Brain",
    config = {
        extra = {
            mult = 2,
            odds = 6,
            mult_mod = 1,
            mult_mod_mod = 1,
        }
    },
    pos = { x = 4, y = 0 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "j_chm_brain")
        return { vars = {
            card.ability.extra.mult,
            numerator,
            denominator,
            card.ability.extra.mult_mod,
            card.ability.extra.mult_mod_mod
        }
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, "j_chm_brain", 1, card.ability.extra.odds) then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                card.ability.extra.mult_mod = card.ability.extra.mult_mod + card.ability.extra.mult_mod_mod
            end
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}