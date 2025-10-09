SMODS.Consumable {
    key = "flowers",
    set = "Lenormand",
    pos = { x = 1, y = 1 },
    config = { extra = {
        edition_amount = 1
    } },
    loc_txt = {
        name = "Flowers",
        text = {
        [1] = "{C:red}Destroy{} a random {C:attention}Joker{}",
        [2] = "Add {C:edition}Holographic{} to a random {C:attention}Joker{}"
    }
    },
    cost = 4,
    atlas = "consumable",
    use = function(self, card, area, copier)
        local used_card = copier or card
            local jokers_to_edition = {}
            local eligible_jokers = {}
            if "editionless" == "editionless" then
                eligible_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
            else
                for _, joker in pairs(G.jokers.cards) do
                    if joker.ability.set == "Joker" then
                        eligible_jokers[#eligible_jokers + 1] = joker
                    end
                end
            end
            if #eligible_jokers > 0 then
                local temp_jokers = {}
                for _, joker in ipairs(eligible_jokers) do 
                    temp_jokers[#temp_jokers + 1] = joker 
                end
                
                pseudoshuffle(temp_jokers, 76543)
                
                for i = 1, math.min(card.ability.extra.edition_amount, #temp_jokers) do
                    jokers_to_edition[#jokers_to_edition + 1] = temp_jokers[i]
                end
            end
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("timpani")
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for _, joker in pairs(jokers_to_edition) do
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
    end,
    can_use = function(self, card)
        return true
    end
}