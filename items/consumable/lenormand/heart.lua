local function foilcardsindeck()
    local count = 0
    for _, card in ipairs(G.playing_cards or {}) do
        if card.edition and card.edition.foil then
            count = count + 1 
        end
    end
    return count
end

local function holographiccardsindeck()
    local count = 0
    for _, card in ipairs(G.playing_cards or {}) do
        if card.edition and card.edition.holo then
            count = count + 1 
        end
    end
    return count
end

local function polychromecardsindeck()
    local count = 0
    for _, card in ipairs(G.playing_cards or {}) do
        if card.edition and card.edition.polychrome then
            count = count + 1 
        end
    end
    return count
end

SMODS.Consumable {
    key = "heart",
    name = "Heart",
    set = "Lenormand",
    pos = { x = 3, y = 2 },
    config = {
        extra = {
            foildollars = 1,
            holographicdollars = 2,
            polychromedollars = 3,
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.foildollars,
                card.ability.extra.holographicdollars,
                card.ability.extra.polychromedollars,
                foilcardsindeck() * card.ability.extra.foildollars,
                holographiccardsindeck() * card.ability.extra.holographicdollars,
                polychromecardsindeck() * card.ability.extra.polychromedollars,
            }
        }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        local affected_card = nil
        if G.hand and #G.hand.cards > 0 then
            affected_card = pseudorandom_element(G.hand.cards, pseudoseed("c_chm_heart"))
        end
        local affected_cards = affected_card and {affected_card} or {}
        local original_foil_count = foilcardsindeck()
        local original_holo_count = holographiccardsindeck()
        local original_poly_count = polychromecardsindeck()
        local added_editions = { foil = false, holo = false, polychrome = false }
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #affected_cards do
            local percent = 1.15 - (i - 0.999) / (#affected_cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    affected_cards[i]:flip()
                    play_sound("card1", percent)
                    affected_cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #affected_cards do
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    local edition_type = pseudorandom_element({ "foil", "holo", "polychrome" }, pseudoseed("c_chm_heart"))
                    local edition = {[edition_type] = true}
                    affected_cards[i]:set_edition(edition, true)
                    added_editions[edition_type] = true
                    if edition_type == "foil" and original_foil_count == 0 then
                        original_foil_count = 1
                    elseif edition_type == "holo" and original_holo_count == 0 then
                        original_holo_count = 1
                    elseif edition_type == "polychrome" and original_poly_count == 0 then
                        original_poly_count = 1
                    end
                    return true
                end
            }))
        end
        for i = 1, #affected_cards do
            local percent = 0.85 + (i - 0.999) / (#affected_cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    affected_cards[i]:flip()
                    play_sound("tarot2", percent, 0.6)
                    affected_cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                local foil_count = foilcardsindeck()
                local holo_count = holographiccardsindeck()
                local poly_count = polychromecardsindeck()
                if (added_editions["foil"] or original_foil_count > 0) and foil_count > 0 then
                    card:juice_up(0.3, 0.5)
                    ease_dollars(foil_count * card.ability.extra.foildollars, true)
                    delay(0.3)
                end
                if (added_editions["holo"] or original_holo_count > 0) and holo_count > 0 then
                    card:juice_up(0.3, 0.5)
                    ease_dollars(holo_count * card.ability.extra.holographicdollars, true)
                    delay(0.3)
                end
                if (added_editions["polychrome"] or original_poly_count > 0) and poly_count > 0 then
                    card:juice_up(0.3, 0.5)
                    ease_dollars(poly_count * card.ability.extra.polychromedollars, true)
                    delay(0.3)
                end
                return true
            end
        }))
    end
}