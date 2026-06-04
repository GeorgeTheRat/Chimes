SMODS.Joker {
    key = "punk",
    name = "Punk Joker",
    config = {
        extra = {
            chips_mod = 20,
            chips = 0
        }
    },
    pos = { x = 8, y = 2 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_mod,
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and context.removed then
            local count = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card:is_suit("Spades") or removed_card:is_suit("Clubs") then
                    count = count + 1
                end
            end
            if count > 0 then
                for i = 1, count do
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "chips",
                        scalar_value = "chips_mod",
                        message_colour = G.C.CHIPS
                    })
                end
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}