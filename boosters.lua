SMODS.Booster {
    key = 'jumbo_lenormand_pack',
    loc_txt = {
        name = "Jumbo Lenormand Pack",
        text = {
            "Choose 1 of up to 4 Lenormand",
            "cards to add to consumable slots"
        },
        group_name = "Jumbo Lenormand Pack"
    },
    config = { extra = 4, choose = 1 },
    cost = 6,
    weight = 0.6,
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    draw_hand = true,
    select_card = "consumeables",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
        set = "lenormand",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "solo_jumbo_lenormand_pack"
        }
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}


SMODS.Booster {
    key = 'lenormand_pack',
    loc_txt = {
        name = "Lenormand Pack",
        text = {
            "Choose 1 of up to 2 Lenormand",
            "cards to add to consumable slots"
        },
        group_name = "Lenormand Pack"
    },
    config = { extra = 2, choose = 1 },
    weight = 0.8,
    atlas = "CustomBoosters",
    pos = { x = 1, y = 0 },
    draw_hand = true,
    select_card = "consumeables",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
        set = "lenormand",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "solo_lenormand_pack"
        }
    end,
    ease_background_colour = function(self)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}


SMODS.Booster {
    key = 'mega_lenormand_pack',
    loc_txt = {
        name = "Mega Lenormand Pack",
        text = {
            "Choose 2 of up to 4 Lenormand",
            "cards to add to consumable slots"
        },
        group_name = "Mega Lenormand Pack"
    },
    config = { extra = 4, choose = 2 },
    cost = 8,
    weight = 0.4,
    atlas = "CustomBoosters",
    pos = { x = 2, y = 0 },
    draw_hand = true,
    select_card = "consumeables",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
        set = "lenormand",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "solo_mega_lenormand_pack"
        }
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}
