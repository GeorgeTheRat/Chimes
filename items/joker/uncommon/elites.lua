SMODS.Joker {
    key = "elites",
    name = "Elites",
    config = { extra = { create = 1 } },
    pos = { x = 9, y = 0 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.create } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind.boss and #G.jokers.cards < G.jokers.config.card_limit then
            for i = 1, card.ability.extra.create do
                SMODS.add_card({
                    set = "Joker",
                    rarity = 3
                })
            end
        end
    end
}