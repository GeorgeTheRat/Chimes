SMODS.Consumable {
    key = 'stork',
    set = 'lenormand',
    pos = { x = 3, y = 2 },
    config = { extra = {
        consumablesheld = 0
    } },
    loc_txt = {
        name = 'Stork',
        text = {
        [1] = 'Add {C:attention}Enhanced Cards{} equal',
        [2] = 'to the number of',
        [3] = '{C:attention}consumables{} owned to hand',
        [4] = '{C:inactive}(#1#){}'
    }
    },
    cost = 4,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    loc_vars = function(self, info_queue, card)
        return {vars = {(#(G.consumeables and G.consumeables.cards or {}) or 0)}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                func = function()
                    local cards = {}
                    for i = 1, #(G.consumeables and G.consumeables.cards or {}) do
                        local _rank = pseudorandom_element(SMODS.Ranks, 'add_random_rank').card_key
                        local _suit = nil
                        local cen_pool = {}
                        for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                            if enhancement_center.key ~= 'm_stone' and not enhancement_center.overrides_base_rank then
                                cen_pool[#cen_pool + 1] = enhancement_center
                            end
                        end
                        local enhancement = pseudorandom_element(cen_pool, 'add_cards_enhancement')
                        local new_card_params = { set = "Base" }
                        if _rank then new_card_params.rank = _rank end
                        if _suit then new_card_params.suit = _suit end
                        if enhancement then new_card_params.enhancement = enhancement.key end
                        cards[i] = SMODS.add_card(new_card_params)
                    end
                    SMODS.calculate_context({ playing_card_added = true, cards = cards })
                    return true
                end
            }))
            delay(0.3)
    end,
    can_use = function(self, card)
        return true
    end
}