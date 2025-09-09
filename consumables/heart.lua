SMODS.Consumable {
    key = 'heart',
    set = 'lenormand',
    pos = { x = 1, y = 1 },
    config = { extra = {
        
        consumable_count = 1
    } },
    loc_txt = {
        name = 'Heart',
        text = {
        [1] = 'Create {C:attention}1{} {C:attention}Lenormand Card{}',
        [2] = 'and {C:attention}1{} {C:planet}Planet Card{}',
        [3] = '{C:inactive}(Must have room){}'
    }
    },
    cost = 4,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    use = function(self, card, area, copier)
        local used_card = copier or card
            for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
            play_sound('timpani')
            SMODS.add_card({ set = Planet, })                            
            used_card:juice_up(0.3, 0.5)
            return true
        end
        }))
    end
    delay(0.6)
            for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
            play_sound('timpani')
            SMODS.add_card({ set = lenormand, })                            
            used_card:juice_up(0.3, 0.5)
            return true
        end
        }))
    end
    delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}