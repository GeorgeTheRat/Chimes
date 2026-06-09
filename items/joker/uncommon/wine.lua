SMODS.Joker {
    key = "wine",
    name = "Wine",
    config = { card_limit = 1, extra = { joker_slots = 1 } },
    pos = { x = 4, y = 4 },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = false,
    discovered = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_negative
        return { vars = { card.ability.extra.joker_slots } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag("tag_negative"))
                    play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
            return nil, true
        end
    end,
    in_pool = function(self, args)
        return
            not args or
            (args.source ~= "buf" and
            args.source ~= "jud" and
            (args.source == "sho" or
            args.source == "rif" or
            args.source == "rta" or
            args.source == "sou" or
            args.source == "uta" or
            args.source == "wra"))
    end,
    check_for_unlock = function(self, args)
        if args.type == "modify_jokers" then
            local count = 0
            for _, joker in ipairs(G.jokers.cards) do
                count = count + 1
            end
            if count >= to_big(9) then
                return true
            end
        end
        return false
    end
}