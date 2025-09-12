SMODS.Joker{ --Salmon Nigiri
    key = "salmonnigiri",
    config = {
        extra = {
            ah = 12,
            pb_h_mult_1e7fdaf6 = 1,
            perma_h_mult = 0,
            explode = 0,
            y = 0
        }
    },
    loc_txt = {
        ['name'] = 'Salmon Nigiri',
        ['text'] = {
            [1] = '{C:red}+#1# {}Mult, decreases by {C:attention}1{}',
            [2] = 'when a card is scored,',
            [3] = 'all cards permanently gain',
            [4] = '{C:red}+1{} Bonus {C:attention}held in hand{} Mult when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_sushi"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.ah}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (card.ability.extra.ah or 0) ~= 0 then
                return {
                    mult = card.ability.extra.ah
                }
            end
        end
        if context.individual and context.cardarea == G.play  then
            if (card.ability.extra.ah or 0) <= 0 then
                return {
                    func = function()
                card:explode()
                return true
            end,
                    message = "Eaten!"
                }
            else
                context.other_card.ability.perma_h_mult = context.other_card.ability.perma_h_mult or 0
                context.other_card.ability.perma_h_mult = context.other_card.ability.perma_h_mult + card.ability.extra.pb_h_mult_1e7fdaf6
                card.ability.extra.ah = math.max(0, (card.ability.extra.ah) - 1)
                return {
                    extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT }, card = card
                }
            end
        end
    end
}