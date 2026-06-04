SMODS.Joker {
    key = "wallbang",
    name = "Wallbang Joker",
    pos = { x = 6, y = 2 },
    cost = 5,
    rarity = 2,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_ricochet
        return { vars = {  } }
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_chm_ricochet") then
                return true
            end
        end
        return false
    end
}