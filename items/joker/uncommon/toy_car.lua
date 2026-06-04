SMODS.Joker {
    key = "toy_car",
    name = "Toy Car",
    config = {
        extra = {
            dollars = 1,
            dollars_mod = 1
        }
    },
    pos = { x = 9, y = 3 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.dollars_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_mod
            return {
                message = "Upgrade!",
                colour = G.C.MONEY
            }
        end
        if context.skip_blind then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end
}