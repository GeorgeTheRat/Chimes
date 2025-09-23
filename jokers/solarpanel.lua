SMODS.Joker{ --Solar Panel
    key = "solarpanel",
    config = {
        extra = {
            varb = 0,
            y = 0
        }
    },
    loc_txt = {
        ['name'] = 'Solar Panel',
        ['text'] = {
            [1] = 'When {C:attention}last hand{} is played create',
            [2] = 'a copy of {C:attention}Sun{} and {C:tarot}The Sun{}',
            [3] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_solo_jokers"] = true },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if G.GAME.current_round.hands_left == 0 then
                local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'lenormand', key = 'c_solo_sun', soulable = nil, key_append = 'joker_forge_lenormand'}
                        return true
                    end
                }))
                local created_consumable = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{set = 'Tarot', key = 'c_sun', soulable = nil, key_append = 'joker_forge_tarot'}
                        return true
                    end
                }))
                return {
                    message = created_consumable and localize('k_plus_consumable') or nil,
                    extra = {
                        message = created_consumable and localize('k_plus_tarot') or nil,
                        colour = G.C.PURPLE
                        }
                }
            end
        end
    end
}
