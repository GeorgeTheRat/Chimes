SMODS.Consumable {
    key = "stork",
    name = "Stork",
    set = "Lenormand",
    pos = { x = 6, y = 1 },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = { ((#(G.consumeables and G.consumeables.cards or {}) or 0)) * 2 }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, (#(G.consumeables and G.consumeables.cards or {})) * 2 do
                    local _rank = pseudorandom_element(SMODS.Ranks, "add_random_rank").card_key
                    local _suit = nil
                    local enhancement_pool = {}
                    for _, enhancement in pairs(G.P_CENTER_POOLS.Enhanced) do
                        if not enhancement.overrides_base_rank then
                            enhancement_pool[#enhancement_pool + 1] = enhancement
                        end
                    end
                    local enhancement = pseudorandom_element(enhancement_pool, "c_chm_stork")
                    local new_card_params = {
                        set = "Base"
                    }
                    if _rank then
                        new_card_params.rank = _rank
                    end
                    if _suit then
                        new_card_params.suit = _suit
                    end
                    if enhancement then
                        new_card_params.enhancement = enhancement.key
                    end
                    cards[i] = SMODS.add_card(new_card_params)
                end
                return {
                    playing_card_added = true,
                    cards = cards
                }
            end
        }))
        delay(0.3)
    end
}