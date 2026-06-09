SMODS.Joker {
    key = "tako_nigiri",
    name = "Tako Nigiri",
    config = {
        extra = {
            create = 6,
            create_mod = 1,
            legendary = 0
        }
    },
    pos = { x = 4, y = 3 },
    cost = 8,
    rarity = 3,
    eternal_compat = false,
    atlas = "joker",
    pools = { ["sushi"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.create,
                card.ability.extra.create_mod,
                card.ability.extra.legendary
            }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            local available_slots = (G.jokers and G.jokers.config.card_limit or 0) - #(G.jokers and G.jokers.cards or {})
            if card.ability.extra.create <= available_slots then
                for i = 1, math.ceil(card.ability.extra.create) do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local joker_card = SMODS.add_card({
                                set = "Joker",
                                rarity = "Rare"
                            })
                            return true
                        end
                    }))
                end
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.BLUE
                }
            elseif card.ability.extra.create <= 0 and available_slots > 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local joker_card = SMODS.add_card({
                            set = "Joker",
                            rarity = "Legendary"
                        })
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.BLUE
                }
            end
        end
        if context.beat_boss and context.main_eval then
            if (card.ability.extra.create or 0) ~= 0 then
                card.ability.extra.create = math.max(0, card.ability.extra.create - card.ability.extra.create_mod)
                if card.ability.extra.create == 1 then
                    card:juice_up(0.3, 0.5)
                end
            end
        end
    end
}