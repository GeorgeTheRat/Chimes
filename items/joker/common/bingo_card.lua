SMODS.Joker{
    key = "bingo_card",
    name = "Bingo Card",
    config = {
        extra = {
            total_req = 5,
            blinds_defeated = 0,
            dollars = 40,
        }
    },
    pos = { x = 2, y = 0 },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.total_req,
                card.ability.extra.blinds_defeated,
                card.ability.extra.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            if card.ability.extra.blinds_defeated + 1 >= card.ability.extra.total_req then
                card.ability.extra.blinds_defeated = 0
                return {
                    dollars = card.ability.extra.dollars,
                    extra = {
                        func = function()
                            local tag = Tag("tag_boss")
                            tag:set_ability()
                            add_tag(tag)
                            play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
                            play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end
                    }
                }
            else
                card.ability.extra.blinds_defeated = card.ability.extra.blinds_defeated + 1
            end
        end
    end
}