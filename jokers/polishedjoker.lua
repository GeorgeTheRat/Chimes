SMODS.Joker{ --Polished Joker
    key = "polishedjoker",
    config = {
        extra = {
            discards = 1,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Polished Joker',
        ['text'] = {
            [1] = 'Gain a temporary Discard when',
            [2] = 'a {C:attention}Polished Card {}is discarded'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',

    calculate = function(self, card, context)
        if context.discard  then
            if SMODS.get_enhancements(context.other_card)["m_solo_polished"] == true then
                return {
                    func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.discards).." Discard", colour = G.C.ORANGE})
                G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + card.ability.extra.discards
                return true
            end
                }
            end
        end
    end
}