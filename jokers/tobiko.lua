SMODS.Joker{ --Tobiko
    key = "tobiko",
    config = {
        extra = {
            rerrooll = 4,
            odds = 4,
            sell_value = 0,
            explode = 0,
            y = 0,
            all_jokers = 0
        }
    },
    loc_txt = {
        ['name'] = 'Tobiko',
        ['text'] = {
            [1] = '{C:attention}+#1#{} Free {C:green}Reroll(s){}',
            [2] = '{C:green}#4# in #5#{} chance to decrease {C:green}Reroll{}',
            [3] = 'amount by {C:attention}1 {}when the shop is {C:green}Rerolled{}',
            [4] = 'When this {C:attention}Joker{} is sold,',
            [5] = 'set the{C:money} sell value {}of all other {C:attention}Jokers{} to {C:red}0{}'
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
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_sushi"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_solo_tobiko') 
        return {vars = {card.ability.extra.rerrooll, card.ability.extra.all_jokers, card.ability.extra.explode, card.ability.extra.y, new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.reroll_shop  then
            if card.ability.extra.rerrooll == 0 then
                return {
                    func = function()
                card:explode()
                return true
            end,
                    message = "Eaten!"
                }
            elseif true then
                if SMODS.pseudorandom_probability(card, 'group_0_dfa28d46', 1, card.ability.extra.odds, 'j_solo_tobiko', false) then
              SMODS.calculate_effect({func = function()
                    card.ability.extra.rerrooll = math.max(0, (card.ability.extra.rerrooll) - 1)
                    return true
                end}, card)
          end
            end
        end
        if context.selling_self  then
                return {
                    func = function()for i, target_card in ipairs(G.jokers.cards) do
                if target_card.set_cost then
            target_joker.ability.extra_value = card.ability.extra.sell_value
            target_joker:set_cost()
            end
        end
                    return true
                end,
                    message = "All Jokers Sell Value: $"..tostring(card.ability.extra.sell_value)
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(card.ability.extra.rerrooll)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(-(card.ability.extra.rerrooll))
    end
}