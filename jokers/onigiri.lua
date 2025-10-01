SMODS.Joker{ --Onigiri
    key = "onigiri",
    config = {
        extra = {
            onioni = 70,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Onigiri',
        ['text'] = {
            [1] = '{C:blue}-70{} Chips',
            [2] = '{C:red}-35{} Chips when a',
            [3] = '{C:red}Discard{} is used,',
            [4] = '{C:attention}+1 Voucher Slot{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
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
    atlas = 'CustomJokers',
    pools = { ["solo_solo_jokers"] = true },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.onioni
                }
        end
        if context.pre_discard  and not context.blueprint then
            if card.ability.extra.onioni == 0 then
                return {
                    func = function()
                card:start_dissolve()
                return true
            end
                }
            else
                return {
                    func = function()
                    card.ability.extra.onioni = math.max(0, (card.ability.extra.onioni) - 35)
                    return true
                end
                }
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_voucher_limit(1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_voucher_limit(-1)
    end
}