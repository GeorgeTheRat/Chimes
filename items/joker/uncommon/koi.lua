SMODS.Joker{
    key = "koi",
    name = "Koi",
    config = {
        extra = {
            perma_h_bonus = 2,
            perma_h_bonus_mod = 1
        }
    },
    pos = { x = 7, y = 1 },
    cost = 6,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return {
            vars = {
                card.ability.extra.perma_h_bonus,
                card.ability.extra.perma_h_bonus_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_h_bonus = (context.other_card.ability.perma_h_bonus or 0) + card.ability.extra.perma_h_bonus
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS
            }
        end
        if context.other_card and context.discard and SMODS.has_enhancement(context.other_card, "m_wild") then
            card.ability.extra.perma_h_bonus = card.ability.extra.perma_h_bonus + card.ability.extra.perma_h_bonus_mod
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS
            }
        end
    end
}