SMODS.Joker{
    key = "batteries",
    name = "Batteries",
    config = {
        extra = { 
            repetitions = 3,
            most_played = "High Card"
        } 
    },
    pos = { x = 1, y = 0 },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions,
                card.ability.extra.most_played
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            local _handname, _played, _order = "High Card", -1, 100
            for k, v in pairs(G.GAME.hands) do
                if v.played > _played or (v.played == _played and _order > v.order) then 
                    _played = v.played
                    _handname = k
                end
            end
            card.ability.extra.most_played = _handname
        end
        if
            context.repetition and
            context.cardarea == G.play and
            context.other_card:get_id() == 14 and
            next(context.poker_hands["Three of a Kind"]) and
            context.scoring_name ~= card.ability.extra.most_played
        then
            
            return {
                repetitions = card.ability.extra.repetitions,
                message = localize("k_again_ex")
            }
        end
    end
}