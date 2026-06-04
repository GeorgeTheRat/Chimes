SMODS.Joker {
    key = "keychain",
    name = "Keychain",
    config = {
        extra = {
            tags = 1,
            tags_mod = 1,
            toggle = 1
        }
    },
    pos = { x = 6, y = 1 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.tags,
                card.ability.extra.tags_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            card.ability.extra.toggle = 0
            for i = 1, card.ability.extra.tags do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                        local tag = Tag(selected_tag)
                        if tag.name == "Orbital Tag" then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then
                                    _poker_hands[#_poker_hands + 1] = k
                                end
                            end
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "j_chm_keychain")
                        end
                        tag:set_ability()
                        add_tag(tag)
                        play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
            end
            return {
                message = "+" .. card.ability.extra.tags .. " Tag" .. (card.ability.extra.tags > 1 and "s" or ""),
                colour = G.C.BLUE
            }
        end
        if card.ability.extra.toggle == 1 and context.tag_added and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "tags",
                scalar_value = "tags_mod",
                scaling_message = {
                    message = "+" .. card.ability.extra.tags_mod .. " Tag" .. (card.ability.extra.tags_mod > 1 and "s" or "")
                }
            })
        end
    end
}