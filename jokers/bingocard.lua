SMODS.Joker{ --Bingo Card
    key = "bingocard",
    config = {
        extra = {
            eyes = 0,
            dollars = 30,
            var1 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Bingo Card',
        ['text'] = {
            [1] = 'Every {C:attention}5{} {C:inactive}[#1#] {}{C:attention}Blinds{} defeated, gain {C:money}$40{} and a {C:attention}Boss Tag{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_solo_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.eyes}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if (card.ability.extra.eyes or 0) == 5 then
                return {
                    dollars = card.ability.extra.dollars,
                    extra = {
                        func = function()
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
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
                    return true
                end,
                            message = "Created Tag!",
                        colour = G.C.GREEN,
                        extra = {
                            func = function()
                    card.ability.extra.eyes = 0
                    return true
                end,
                            colour = G.C.BLUE
                        }
                        }
                }
            else
                return {
                    func = function()
                    card.ability.extra.var1 = (card.ability.extra.var1) + 1
                    return true
                end
                }
            end
        end
    end
}