SMODS.Consumable {
    key = 'snake',
    set = 'lenormand',
    pos = { x = 9, y = 2 },
    config = { extra = {
        destroy_count = 100,
        odds = 3
    } },
    loc_txt = {
        name = 'Snake',
        text = {
        [1] = 'Destroys all cards in hand',
        [2] = '{C:green}#1# in #2#{} chance to also {C:hearts}destroy{} a random {C:attention}Joker{}'
    }
    },
    cost = 4,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'c_solo_snake')
        return {vars = {numerator, denominator}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
            local destroyed_cards = {}
            local temp_hand = {}

            for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
            table.sort(temp_hand,
                function(a, b)
                    return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
                end
            )

            pseudoshuffle(temp_hand, 12345)

            for i = 1, 100 do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            SMODS.destroy_cards(destroyed_cards)

            delay(0.5)
    end,
    can_use = function(self, card)
        return true
    end
}