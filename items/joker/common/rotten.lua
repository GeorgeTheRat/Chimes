SMODS.Joker {
    key = "rotten",
    name = "Rotten Joker",
    config = {
        extra = {
            xmult = 0.75,
            dollars = 6
        }
    },
    pos = { x = 0, y = 3 },
    cost = 6,
    rarity = 1,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_chm_rotten
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.dollars
            }
        }
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_chm_rotten") then
                return true
            end
        end
        return false
    end
}