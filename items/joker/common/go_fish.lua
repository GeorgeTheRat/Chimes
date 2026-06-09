SMODS.Joker {
    key = "go_fish",
    name = "Go Fish",
    config = { extra = { card_draw = 6 } },
    pos = { x = 4, y = 1 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    atlas = "joker",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize((G.GAME.current_round.r1_card or {}).rank or "Ace", "ranks"),
                localize((G.GAME.current_round.r2_card or {}).rank or "Ace", "ranks")
            }
        }
    end,
    set_ability = function(self, card, initial)
        G.GAME.current_round.r1_card = {
            rank = "Ace",
            id = 14
        }
        G.GAME.current_round.r2_card = {
            rank = "King",
            id = 13
        }
    end,
    calculate = function(self, card, context)
        local function is_rank_not_in_hand(hand, rank_id)
            for _, card in ipairs(hand) do
                if card:get_id() == rank_id then
                    return false
                end
            end
            return true
        end
        local function update_target_card(target_key, seed_suffix)
            if not G.playing_cards then
                return
            end
            local valid_cards = {}
            for _, v in ipairs(G.playing_cards) do
                if not SMODS.has_no_rank(v) then
                    table.insert(valid_cards, v)
                end
            end
            if #valid_cards > 0 then
                local selected = pseudorandom_element(valid_cards, pseudoseed(seed_suffix .. G.GAME.round_resets.ante))
                G.GAME.current_round[target_key] = {
                    rank = selected.base.value,
                    id = selected.base.id
                }
            end
        end
        if context.joker_main and #context.full_hand >= 5 then
            local r1_missing = is_rank_not_in_hand(context.full_hand, G.GAME.current_round.r1_card.id)
            local r2_missing = is_rank_not_in_hand(context.full_hand, G.GAME.current_round.r2_card.id)
            if r1_missing and r2_missing and G.GAME.blind.in_blind then
                local cards_to_draw = card.ability.extra.card_draw
                SMODS.draw_cards(cards_to_draw)
                return {
                    message = string.format("+%d Cards Drawn", cards_to_draw)
                }
            end
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            update_target_card("r1_card", "r1")
            update_target_card("r2_card", "r2")
        end
    end
}