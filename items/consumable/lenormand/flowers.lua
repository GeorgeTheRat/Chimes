SMODS.Consumable {
    key = "flowers",
    name = "Flowers",
    set = "Lenormand",
    pos = { x = 8, y = 0 },
    config = {
        extra = {
            destroy = 1,
            edition = 1
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        return {
            vars = {
                card.ability.extra.destroy,
                card.ability.extra.edition
            }
        }
    end,
    can_use = function(self, card)
        return #G.jokers.cards > 0
    end,
    use = function(self, card, area, copier)
        local destructable_jokers = {}
        for i = 1, #G.jokers.cards do
            local joker = G.jokers.cards[i]
            if joker ~= card and not SMODS.is_eternal(joker, card) and not joker.getting_sliced then
                table.insert(destructable_jokers, joker)
            end
        end
        local joker_to_destroy = #destructable_jokers > 0 and 
            pseudorandom_element(destructable_jokers, "c_chm_flowers") or nil
        if joker_to_destroy then
            for _ = 1, card.ability.extra.destroy do
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
            end
        end
        local used_card = copier or card
        local jokers_to_edition = {}
        local eligible_jokers = {}
        for _, joker in ipairs(G.jokers.cards) do
            if joker ~= card and joker ~= joker_to_destroy and joker.ability.set == "Joker" and (not joker.edition or not joker.edition.holo) then
                table.insert(eligible_jokers, joker)
            end
        end
        if #eligible_jokers > 0 then
            local temp_jokers = {}
            for _, joker in ipairs(eligible_jokers) do
                table.insert(temp_jokers, joker)
            end
            pseudoshuffle(temp_jokers, 76543)
            local max_editions = math.min(card.ability.extra.edition, #temp_jokers)
            for i = 1, max_editions do
                table.insert(jokers_to_edition, temp_jokers[i])
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for _, joker in ipairs(jokers_to_edition) do
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        joker:set_edition({ holo = true }, true)
                        return true
                    end
                }))
            end
            delay(0.6)
        else
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
        end
    end
}