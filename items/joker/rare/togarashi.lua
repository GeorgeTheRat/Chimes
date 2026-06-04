SMODS.Joker {
    key = "togarashi",
    name = "Togarashi",
    config = {
        extra = {
            mult_mod1 = 2,
            mult_mod2 = 3,
            mult = 0,
        }
    },
    pos = { x = 7, y = 3 },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_mod1,
                card.ability.extra.mult_mod2,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and (context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds")) then
            card.ability.extra.mult = math.max(0, card.ability.extra.mult + card.ability.extra.mult_mod1)
            return {
                message = "Upgrade!",
                colour = G.C.MULT,
                card = context.other_card
            }
        end
        if context.individual and context.cardarea == G.play and (context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds")) then
            card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.mult_mod2)
            return {
                message = "Downgrade!",
                colour = G.C.MULT,
                card = context.other_card
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
            }
        end
    end
}