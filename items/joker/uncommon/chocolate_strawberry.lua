SMODS.Joker{
    key = "chocolate_strawberry",
    name = "Chocolate Strawberry",
    config = { extra = { joker_slots = 4, joker_slots_mod = 1, context = 1 } },
    pos = { x = 6, y = 0 },
    cost = 4,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.joker_slots,
                card.ability.extra.joker_slots_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if (G.GAME.blind.in_blind and not context.blueprint) and card.ability.extra.context == 1 then
            G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots
            card.ability.extra.context = 0
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            if card.ability.extra.joker_slots >= 2 then
                G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
                card.ability.extra.joker_slots = card.ability.extra.joker_slots - card.ability.extra.joker_slots_mod
                card.ability.extra.context = 1
            end
            if card.ability.extra.joker_slots == 1 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex")
                }
            end
        end
    end,
    remove_from_deck = function(self, card)
        if G.GAME.blind.in_blind then
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
            card.ability.extra.joker_slots = card.ability.extra.joker_slots - card.ability.extra.joker_slots_mod
        end
    end
}