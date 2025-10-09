SMODS.Joker{ --Keychain
    key = "keychain",
    config = {
        extra = {
            nun = 0
        }
    },
    loc_txt = {
        ["name"] = "Keychain",
        ["text"] = {
            [1] = "Create {C:attention}1{} random {C:attention}Tag{} when sold",
            [2] = "Increase by {C:attention}1{} when a {C:attention}Tag{} is obtained"
        },
        ["unlock"] = {
            [1] = "Unlocked by default."
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = "joker",
    pools = { ["chm_chm_kers"] = true },

    calculate = function(self, card, context)
        if context.selling_self  then
            if true then
                for i = 1, card.ability.extra.nun do
              SMODS.calculate_effect({func = function()
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
                        tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                    end
                    tag:set_ability()
                    add_tag(tag)
                    play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
                    return true
                end}, card)
                        card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {message = "Created Tag!", colour = G.C.GREEN})
          end
            end
        end
        if context.tag_added and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.nun = (card.ability.extra.nun) + 1
                    return true
                end
                }
        end
    end
}