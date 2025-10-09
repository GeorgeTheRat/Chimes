SMODS.Consumable {
    key = "scythe",
    set = "Lenormand",
    pos = { x = 5, y = 2 },
    config = { extra = {
        money_10 = 0
    } },
    loc_txt = {
        name = "Scythe",
        text = {
        [1] = "Destroy {C:attention}1{} card in hand for",
        [2] = "every {C:money}$10{} you have",
        [3] = "{C:inactive}(Currently #1#){}"
    }
    },
    cost = 4,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = "consumable",
    loc_vars = function(self, info_queue, card)
        return {vars = {(math.floor(lenient_bignum(G.GAME.dollars / 10)) or 0)}}
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

            for i = 1, math.floor(lenient_bignum(G.GAME.dollars / 10)) do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    play_sound("tarot1")
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