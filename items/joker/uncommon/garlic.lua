SMODS.Joker {
    key = "garlic",
    name = "Garlic",
    config = {
        extra = {
            xmult = 2.5,
            xmult_mod = 0.1
        }
    },
    pos = { x = 2, y = 1 },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { 
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local count = 0
            for _, playing_card in pairs(context.scoring_hand or {}) do
                if not next(SMODS.get_enhancements(playing_card)) then
                    count = count + 1
                end
            end
            if card.ability.extra.xmult - (count * card.ability.extra.xmult_mod) > 1 then
                for i = 1, count do
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_value = "xmult_mod",
                        operation = "-",
                        no_message = true
                    })
                end
            else
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}