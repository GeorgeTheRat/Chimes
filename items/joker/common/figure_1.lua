SMODS.Joker{
    key = "figure_1",
    name = "Figure 1",
    pos = { x = 0, y = 1 },
    atlas = "joker",
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_literature
        return { vars = { } }
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_chm_literature") then
                return true
            end
        end
        return false
    end
}