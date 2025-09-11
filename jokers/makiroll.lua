SMODS.Joker{ --Maki Roll
    key = "makiroll",
    config = {
        extra = {
            all = 4,
            left = 4,
            tf = 1
        }
    },
    loc_txt = {
        ['name'] = 'Maki Roll',
        ['text'] = {
            [1] = '{C:attention}+#3# {}{C:attention}Booster Pack {}slots, gain {C:money}$3{} when exiting shop',
            [2] = 'for every {C:attention}Booster Pack {}that {C:red}wasn\'t{} opened',
            [3] = 'Decreases by {C:attention}1{} slot and {C:money}$1{} when shop is entered'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["solo_sushi"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.all, card.ability.extra.left, card.ability.extra.tf}}
    end,

    calculate = function(self, card, context)
        if context.ending_shop  then
            if (card.ability.extra.left or 0) == 1 then
                return {
                    dollars = card.ability.extra.all
                }
            elseif (card.ability.extra.left or 0) == 2 then
                return {
                    dollars = card.ability.extra.all,
                    extra = {
                        dollars = card.ability.extra.all,
                        colour = G.C.MONEY
                        }
                }
            elseif (card.ability.extra.left or 0) == 3 then
                return {
                    dollars = card.ability.extra.all,
                    extra = {
                        dollars = card.ability.extra.all,
                        colour = G.C.MONEY,
                        extra = {
                            dollars = card.ability.extra.all,
                            colour = G.C.MONEY
                        }
                        }
                }
            elseif (card.ability.extra.left or 0) == 4 then
                return {
                    dollars = card.ability.extra.all,
                    extra = {
                        dollars = card.ability.extra.all,
                        colour = G.C.MONEY,
                        extra = {
                            dollars = card.ability.extra.all,
                            colour = G.C.MONEY,
                        extra = {
                            dollars = card.ability.extra.all,
                            colour = G.C.MONEY
                        }
                        }
                        }
                }
            elseif (card.ability.extra.left or 0) == 5 then
                return {
                    dollars = card.ability.extra.all,
                    extra = {
                        dollars = card.ability.extra.all,
                        colour = G.C.MONEY,
                        extra = {
                            dollars = card.ability.extra.all,
                            colour = G.C.MONEY,
                        extra = {
                            dollars = card.ability.extra.all,
                            colour = G.C.MONEY,
                        extra = {
                            dollars = card.ability.extra.all,
                            colour = G.C.MONEY
                        }
                        }
                        }
                        }
                }
            elseif (card.ability.extra.left or 0) == 6 then
                return {
                    dollars = card.ability.extra.all,
                    extra = {
                        dollars = card.ability.extra.all,
                        colour = G.C.MONEY,
                        extra = {
                            dollars = card.ability.extra.all,
                            colour = G.C.MONEY,
                        extra = {
                            dollars = card.ability.extra.all,
                            colour = G.C.MONEY,
                        extra = {
                            dollars = card.ability.extra.all,
                            colour = G.C.MONEY,
                        extra = {
                            dollars = card.ability.extra.all,
                            colour = G.C.MONEY
                        }
                        }
                        }
                        }
                        }
                }
            elseif (card.ability.extra.left or 0) == 0 then
                return {
                    func = function()
                card:undefined()
                return true
            end
                }
            end
        end
        if context.open_booster  and not context.blueprint then
            if ((card.ability.extra.tf or 0) == 1 and (function()
      for i = 1, #G.jokers.cards do
          if G.jokers.cards[i].config.center.key == "j_trickster" then
              return true
          end
      end
      return false
  end)()) then
                return {
                    func = function()
                    card.ability.extra.left = 6
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.tf = 0
                    return true
                end,
                        colour = G.C.BLUE
                        }
                }
            elseif (card.ability.extra.tf or 0) == 1 then
                return {
                    func = function()
                    card.ability.extra.left = 5
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.tf = 0
                    return true
                end,
                        colour = G.C.BLUE
                        }
                }
            elseif (card.ability.extra.tf or 0) == 0 then
                return {
                    func = function()
                    card.ability.extra.left = math.max(0, (card.ability.extra.left) - 1)
                    return true
                end
                }
            end
        end
        if context.starting_shop  and not context.blueprint then
                return {
                    func = function()
                    card.ability.extra.tf = 1
                    return true
                end,
                    extra = {
                        func = function()
                    card.ability.extra.all = math.max(0, (card.ability.extra.all) - 1)
                    return true
                end,
                        colour = G.C.RED
                        }
                }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(card.ability.extra.all)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(-card.ability.extra.all)
    end
}