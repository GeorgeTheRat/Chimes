SMODS.Consumable {
    key = "rider",
    name = "Rider",
    set = "Lenormand",
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            tags = 2,
            dollars = 25
        }
    },
    cost = 4,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_investment
        return {
            vars = {
                card.ability.extra.tags,
                card.ability.extra.dollars
            }
        }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        for i = 1, card.ability.extra.tags do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local tag = Tag("tag_investment")
                    tag:set_ability()
                    add_tag(tag)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    used_card:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                used_card:juice_up(0.3, 0.5)
                ease_dollars(-card.ability.extra.dollars, true)
                return true
            end
        }))
        delay(0.6)
    end
}