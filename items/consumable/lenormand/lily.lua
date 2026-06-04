SMODS.Consumable {
    key = "lily",
    name = "Lily",
    set = "Lenormand",
    pos = { x = 9, y = 2 },
    cost = 4,
    atlas = "consumable",
    can_use = function(self, card)
        return true
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_coupon
        info_queue[#info_queue + 1] = G.P_TAGS.tag_d_six
        return { vars = {  } }
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_coupon")
                tag:set_ability()
                add_tag(tag)
                play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                local tag = Tag("tag_d_six")
                tag:set_ability()
                add_tag(tag)
                play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end
}