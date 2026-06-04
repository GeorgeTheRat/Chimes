SMODS.Enhancement {
    key = "overgrown",
    name = "Overgrown",
    pos = { x = 4, y = 0 },
    config = { chips = 5 },
    atlas = "enhancement",
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.chips } }
    end,
    in_pool = function(self, args)
        return false
    end
}