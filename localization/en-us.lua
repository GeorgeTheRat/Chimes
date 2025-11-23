return {
	descriptions = {
		Joker = {
			j_chm_bingo_card = {
				name = "Bingo Card",
				text = {
					"Every {C:attention}#1#{} {C:inactive}(#2#) {}{C:attention}Blinds",
					"defeated, earn {C:money}$#3#{} and",
					"create a {C:attention}Boss Tag"
				}
			},
			j_chm_alarm = {
				name = "Alarm",
				text = {
					"Cards in {C:attention}first hand{} of round give",
					"{X:red,C:white}X#1#{} Mult when scored if no",
					"{C:attention}discards{} have been used this round"
				}
			},
			j_chm_batteries = {
				name = "Batteries",
				text = {
					"Retrigger each played {C:attention}Ace",
					"{C:attention}#1#{} additional time#<s>1# if played hand",
					"contains a {C:attention}Three of a Kind{} and is {C:red}not",
					"the most played {C:attention}poker hand"
				}
			},
			j_chm_brain = {
				name = "Brain",
				text = {
					"{C:red}+#1#{} Mult",
					"{C:green}#2# in #3#{} chance for this Joker to",
					"gain {C:red}+#4#{} Mult and further increase",
					"Mult gain by {C:attention}+#5#{} when hand played"
				}
			},
			j_chm_california_roll = {
				name = "California Roll",
				text = {
					"Create {C:attention}#1#{}",
					"{C:attention}Joker#<s>1#{} and {C:attention}Consumable#<s>1#",
					"when this Joker is sold",
					"Decrease by {C:red}-#2#{} and create a",
					"{C:attention}Tag{}, {C:attention}Joker{}, and {C:attention}consumable",
					"when a {C:attention}playing card{} is added to deck"
				}
			},
			j_chm_makisu = {
				name = "Makisu",
				text = {
					"Create a random {C:attention}Sushi Joker",
					"when a {C:attention}consumable{} is used",
					"during a {C:attention}Boss Blind",
					"{C:inactive}(Must have room)"
				}
			},
			j_chm_chocolate_strawberry = {
				name = "Chocolate Strawberry",
				text = {
					"{C:dark_edition}+#1#{} Joker slots while in a {C:attention}Blind",
					"Decreases by {C:dark_edition}-#2#{} at end of round"
				}
			},
			j_chm_colored_pencils = {
				name = "Colored Pencils",
				text = {
					"If {C:attention}last hand{} of round",
					"has only {C:attention}1{} card,",
					"apply {C:dark_edition}Polychrome{} to it "
				}
			},
			j_chm_crayons = {
				name = "Crayons",
				text = {
					"If {C:attention}last hand{} of round",
					"has exactly {C:attention}3{} cards,",
					"apply {C:dark_edition}Foil{} to them"
				}
			},
			j_chm_watercolors = {
				name = "Watercolors",
				text = {
					"If {C:attention}last hand{} of round",
					"has exactly {C:attention}2{} cards,",
					"apply {C:dark_edition}Holographic{} to them"
				}
			},
			j_chm_elites = {
				name = "Elites",
				text = {
					"Create {C:attention}#1#{} random {C:rare}Rare{} {C:attention}Joker",
					"when {C:attention}Boss Blind{} is selected",
					"{C:inactive}(Must have room)"
				}
			},
			j_chm_figure_1 = {
				name = "Figure 1",
				text = {
					"Played {C:attention}Literature",
					"{C:attention}Cards{} also give their",
					"{C:chips}+Chips{} when scored"
				}
			},
			j_chm_fungi = {
				name = "Fungi",
				text = {
					"Discarded cards on the last discard",
					"of round add a {C:attention}playing card{} with",
					"a random {C:attention}rank{} and {C:attention}suit{} to deck"
				}
			},
			j_chm_garlic = {
				name = "Garlic",
				text = {
					"{X:red,C:white}X#1#{} Mult, decreases",
					"by {X:red,C:white}X#2#{} Mult for each {C:attention}Unenhanced",
					"card in played hand"
				}
			},
			j_chm_ghost_costume = {
				name = "Ghost Costume",
				text = {
					"{C:green}#1# in #2#{} chance to apply {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
					"or {C:dark_edition}Polychrome{} to scored cards,",
					"{C:red}-$#3#{} and create another",
					"{C:attention}Costume Joker{} when sold"
				}
			},
			j_chm_go_fish = {
				name = "Go Fish",
				text = {
					"Draw {C:attention}6{} cards to hand if a",
					"{C:attention}5{} card hand that has no",
					"{C:attention}#1#{} or {C:attention}#2# is played",
					"{s:0.8}Ranks change at end of round"
				}
			},
			j_chm_hand_roll = {
				name = "Hand Roll",
				text = {
					"{C:blue}+#1#{} hands when {C:attention}Blind{} is selected, earn",
					"{C:money}$#2#{} for each hand remaining at end of round",
					"Decreases by {C:blue}-#3#{} <hand,hands>#3# and {C:red}-$#4#{} at end of round"
				}
			},
			j_chm_keychain = {
				name = "Keychain",
				text = {
					"Create {C:attention}#1#{} random",
					"{C:attention}Tag#<s>1#{} when sold",
					"Increases by {C:attention}#2#{} when a",
					"{C:attention}Tag{} is obtained"
				}
			},
			j_chm_koi = {
				name = "Koi",
				text = {
					"Played cards gain {C:blue}+2{} held",
					"in hand Chips when scored,",
					"increases by {C:attention}+1{} when a",
					"{C:attention}Wild Card{} is discarded"
				}
			},
			j_chm_motherboard = {
				name = "Motherboard",
				text = {
					"{C:blue}+#1#{} Chips,",
					"this Joker gains {C:blue}+#2#{} Chips",
					"when a {C:attention}listed {C:green,E:1}probability{} fails",
					"and loses {C:red}-#3#{} Chips when",
					"a {C:attention}listed {C:green,E:1}probability{} succeeds"
				}
			},
			j_chm_train_ticket = {
				name = "Train Ticket",
				text = {
					"{C:red}+#1#{} discards when",
					"{C:attention}third{} hand is played"
				}
			},
			j_chm_monster_costume = {
				name = "Monster Costume",
				text = {
					"Scored cards have a",
					"{C:green}#4# in #5#{} chance of having a",
					"random {C:attention}Enhancement{} applied to them,",
					"{C:red}-$10{} and create another",
					"{C:attention}Costume Joker{} when sold"
				}
			},
			j_chm_onigiri = {
				name = "Onigiri",
				text = {
					"{C:red}#1#{} Chips",
					"This Joker gains {C:blue}+#2#{} Chips",
					"per discard, and is",
					"destroyed at {C:chips}+#3#{} Chips",
					"{C:attention}+#4#{} Voucher slot"
				}
			},
			j_chm_overgrown = {
				name = "Overgrown Joker",
				text = {
					"{C:attention}+#1#{} consumable slots,",
					"halve all {C:attention}listed",
					"{C:green,E:1}probabilities{} on {C:attention}Vine Cards"
				}
			},
			j_chm_wallbang = {
				name = "Wallbang",
				text = {
					"{C:attention}Ricochet{} cards additionally",
					"upgrade when held in hand"
				}
			},
			j_chm_celosia = {
				name = "Celosia",
				text = {
					"Each {C:diamonds}Diamond{} card held in hand",
					"has a {C:green}#1# in #2#{} chance to create",
					"{C:attention}#3#{} random {C:dark_edition}Negative {C:tarot}Tarot{} card#<s>3#",
				}
			},
			j_chm_bonsai = {
				name = "Bonsai",
				text = {
					"Each {C:hearts}Heart{} card held in hand",
					"has a {C:green}#1# in #2#{} chance to create",
					"{C:attention}#3#{} random {C:lenormand}Lenormand{} card#<s>3#",
					"{C:inactive}(Must have room)"
				}
			},
			j_chm_orchid = {
				name = "Orchid",
				text = {
					"Each {C:spades}Spade{} card held in hand",
					"has a {C:green}#1# in #2#{} chance to create",
					"{C:attention}#3#{} random {C:spectral}Spectral{} card#<s>3#",
					"{C:inactive}(Must have room)"
				}
			},
			j_chm_botton_pon= {
				name = "Botton Pon",
				text = {
					"Each {C:clubs}Club{} card held in hand",
					"has a {C:green}#1# in #2#{} chance to create",
					"{C:attention}#3#{} {C:planet}Planet{} card#<s>3# in {C:green,E:1}collection order",
					"{C:inactive,s:0.8}(ex: Mercury, Venus, Earth, Mars, etc.)",
					"{C:inactive}(Must have room)"
				}
			},
			j_chm_rock = {
				name = "Rock",
				text = {
					"{C:chips}#1#{} Chips",
					"{C:white,X:mult}X#2#{} Mult"
				}
			},
			j_chm_paper = {
				name = "Paper",
				text = {
					"{C:mult}#1#{} Mult",
					"{C:chips}+#2#{} Chips",
				}
			},
			j_chm_scissors = {
				name = "Scissors",
				text = {
					"{C:white,X:mult}X#1#{} Mult",
					"{C:red}+#2#{} Mult"
				}
			},
			j_chm_rotten = {
				name = "Rotten Joker",
				text = {
					"{C:attention}Rotten Cards{} instead",
					"give {C:white,X:mult}X#1#{} Mult and",
					"{C:money}$#2#{} when scored"
				}
			},
			j_chm_trickster = {
				name = "Trickster",
				text = {
					"{C:attention}+#1#{} card slot",
					"available in shop"
				}
			},
			j_chm_toycar = {
				name = "Toy Car",
				text = {
					"Earn {C:money}$#1#{} when a",
					"{C:attention}Blind{} is skipped,",
					"increases by {C:money}$#2#{}",
					"at end of round"
				}
			},
			j_chm_waterfall = {
				name = "Waterfall",
				text = {
					"Retrigger each played",
					"{C:attention}6{}, {C:attention}7{}, {C:attention}8{}, {C:attention}9{}, and {C:attention}10{} once for each",
					"{C:attention}Two Pair{} played previously this round",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive} retriggers)"
				}
			},
			j_chm_wine = {
				name = "Wine",
				text = {
					"{C:dark_edition}+#1#{} Joker Slot",
					"Sell this card to create",
					"a free {C:attention}Negative Tag"
				},
				unlock = {
					"Have at least",
					"{C:attention,E:2}9{} Jokers at once"
				}
			},
			j_chm_wonders = {
				name = "Wonders",
				text = {
					"Played {C:attention}7s{} give {C:white,X:mult}X#1#{} Mult when scored",
					"{C:attention}7s{} give {C:dollars}$#2#{} when held in hand",
					"for every {C:attention}7{} in played hand"
				}
			},
			j_chm_togarashi = {
				name = "Togarashi",
				text = {
					"Played cards with {C:hearts}Heart{} or {C:diamonds}Diamond",
					"suit give {C:mult}-#1#{} Mult when scored",
					"This Joker gains {C:mult}+#2#{} Mult per card with",
					"{C:hearts}Heart{} or {C:diamonds}Diamond{} suit held in hand",
					"{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult){}"
				}
			},
			j_chm_punk = {
				name = "Punk Joker",
				text = {
					"This Joker gains {C:blue}+#1#{} Chips",
					"when a {C:spades}Spade{} or {C:clubs}Club{}",
					"card is destroyed",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
				}
			},
			j_chm_tako_nigiri = {
				name = "Tako Nigiri",
				text = {
					"Sell this card to create {C:attention}#1# {C:rare}Rare {C:attention}Joker#<s>1#",
					"if there is room for all of them",
					"Decreases by {C:red}-#2# when a {C:attention}Boss Blind{} is defeated",
					"At {C:attention}#3#{}, create a random {C:legendary}Legendary {C:attention}Joker"
				}
			},
			j_chm_tamago = {
				name = "Tamago",
				text = {
					"Sell this card to gain {C:money}$#1#{}",
					"Decrease by {C:red}-$#2#{} and increase {C:attention}sell value",
					"of the {C:attention}Joker{} to the right by {C:money}$#3#",
					"whenever a {C:attention}Blind{} is skipped"
				}
			},
			j_chm_pumpkincostume = {
				name = "Pumpkin Costume",
				text = {
					"{C:green}#1# in #2#{} chance to apply a",
					"random {C:attention}Seal{} to scored cards",
					"{C:red}-$#3#{} and create another",
					"{C:attention}Costume Joker{} when sold"
				}
			},
			j_chm_salmon_nigiri = {
				name = "Salmon Nigiri",
				text = {
					"{C:mult}+#1#{} Mult",
					"decreases by {C:red}-#2# when a card is scored",
					"All cards permanently gain {C:mult}+#3#",
					"bonus held in hand Mult when scored"
				}
			},
			j_chm_tobiko = {
				name = "Tobiko",
				text = {
					"{C:attention}+#1#{} free {C:green}Reroll#<s>1#",
					"{C:green}#2# in #3#{} chance to decrease {C:green}Reroll",
					"amount by {C:attention}#4#{} when the shop is {C:green}rerolled",
					"When this {C:attention}Joker{} is sold,",
					"set {C:attention}sell value{} of all other {C:attention}Jokers{} to {C:money}$#5#"
				}
			}
		},
        Lenormand = {
			c_chm_rider = {
				name = "Rider",
				text = {
					"Create {C:attention}#1# Investment",
					"{C:attention}Tag#<s>1#{} and lose {C:red}-$#2#"
				}
			},
			c_chm_clover = {
				name = "Clover",
				text = {
					"Enhances up to {C:attention}#1#",
					"selected card#<s>1# into a",
					"{C:attention}Vine Card"
				}
			},
			c_chm_ship = {
				name = "Ship",
				text = {
					"Destroy all cards in hand,",
					"create {C:attention}#1#{} cards with",
					"a random {C:attention}rank{} and {C:attention}suit",
				}
			},
			c_chm_house = {
				name = "House",
				text = {
					"Add a {C:attention}permanent{} bonus",
					"{C:blue}+#1#{} held in hand Chips",
					"to up to {C:attention}#2#{} selected card#<s>2#"
				}
			},
			c_chm_tree = {
				name = "Tree",
				text = {
					"Earn {C:money}$#1#{} for each card below",
					"{C:attention}#2#{} in your full deck",
					"{C:inactive}(Currently {C:money}+$#3#{C:inactive})"
				}
			},
			c_chm_clouds = {
				name = "Clouds",
				text = {
					"Create {C:attention}#1#{} card#<s>1# with a random {C:enhanced}Enhancement,",
					"{C:attention}#2#{} card#<s>2# with a random {C:dark_edition}Edition,",
					"and {C:attention}#3#{} card#<s>3# with a random {C:attention}Seal",
				}
			},
			c_chm_snake = {
				name = "Snake",
				text = {
					"Destroys all cards in hand,",
					"{C:green}#1# in #2#{} chance to also",
					"destroy {C:attention}#3#{} random {C:attention}Joker#<s>1#"
				}
			},
			c_chm_coffin = {
				name = "Coffin",
				text = {
					"Destroy {C:attention}#1#{} random",
					"cards in hand,",
					"create {C:attention}#2#{} cards",
					"with random {C:dark_edition}Editions"
				}
			},
			c_chm_flowers = {
				name = "Flowers",
				text = {
					"Destroy {C:attention}#1#{} random {C:attention}Joker#<s>1#,",
					"apply {C:dark_edition}Holographic{} to",
					"{C:attention}#2#{} random {C:attention}Joker#<s>2#"
				}
			},
			c_chm_scythe = {
				name = "Scythe",
				text = {
					"Destroy {C:attention}#1#{} random card#<s>1# in hand",
					"per {C:money}$#2#{} you have",
					"{C:inactive}(Currently {C:attention}#3#{C:inactive})"
				}
			},
            c_chm_whip = {
				name = "Whip",
				text = {
					"Destroy {C:attention}#1#{} random card#<s>1#",
					"held in hand",
					"and {C:attention}#2#{} selected card#<s>2#"
				}
			},
			c_chm_birds = {
				name = "Birds",
				text = {
					"Apply {C:dark_edition}Foil{} to",
					"up to {C:attention}#1#",
					"selected card#<s>1#"
				}
			},
			c_chm_child = {
				name = "Child",
				text = {
					"Enhances up to {C:attention}#1#",
					"selected card#<s>1# into",
					"{C:attention}Doodle Cards"
				}
			},
			c_chm_fox = {
				name = "Fox",
				text = {
					"Create a {C:blue}Common{}, {C:green}Uncommon{}, and {C:rare}Rare",
					"{C:attention}Joker{} if used during a blind",
					"Creates {C:attention}Fox{} if used while",
					"outside of a {C:attention}Blind",
					"{C:inactive}(Must have room)"
				}
			},
			c_chm_bear = {
				name = "Bear",
				text = {
					"Lose {C:red}-$#1#{} for",
					"every {C:money}$#2#{} owned",
					"Quadruple money"
				}
			},
			c_chm_stars = {
				name = "Stars",
				text = {
					"Level up a random {C:attention}poker hand #1#{} time",
					"for each {C:attention}Blind{} skipped this run",
					"{C:inactive}(Currently {C:attention}#2#{C:inactive})"
				}
			},
			c_chm_stork = {
				name = "Stork",
				text = {
					"Add {C:attention}Enhanced Cards{} equal",
					"to {C:attention}double{} the number of",
					"{C:attention}consumables{} owned to hand",
					"{C:inactive}(Currently {C:attention}#1#{C:inactive})"
				}
			},
			c_chm_dog = {
				name = "Dog",
				text = {
					"Add the {C:attention}rank{} of the",
					"lowest ranked card in",
					"hand to the bonus",
					"held in hand {C:mult}+Mult",
					"of {C:attention}1{} selected card"
				}
			},
			c_chm_tower = {
				name = "Tower",
				text = {
					"Add a permanent {C:mult}+2{} Mult",
					"to up to {C:attention}4{} selected cards"
				}
			},
			c_chm_garden = {
				name = "Garden",
				text = {
					"Earn {C:attention}#1#X{} the value",
					"of the {C:attention}lowest ranked",
					"card in hand as money"
				}
			},
			c_chm_mountain = {
				name = "Mountain",
				text = {
					"{C:attention}+#1#{} {C:attention}Voucher{} and",
					"{C:attention}Booster Pack{} slots,",
					"{C:red}-#2#{} hand size"
				}
			},
			c_chm_crossroads = {
				name = "Crossroads",
				text = {
					"Select {C:attention}1{} card, {C:green}#1# in #2#",
					"chance to destroy it",
					"Otherwise, {C:green}#1# in #2#{} chance to",
					"create {C:attention}3{} copies of it"
				}
			},
			c_chm_mice = {
				name = "Mice",
				text = {
					"Enhances up to {C:attention}#1#",
					"selected cards into",
					"{C:attention}Rotten Cards"
				}
			},
			-- the heart
			c_chm_ring = {
				name = "Ring",
				text = {
					"Create {C:attention}#1#{} copy of up to",
					"{C:attention}#1#{} selected {C:attention}playing cards",
					"Remove their {C:enhanced}Enhancements{}"
				}
			},
			c_chm_book = {
				name = "Book",
				text = {
					"Enhances {C:attention}#1#",
					"selected card into a",
					"{C:attention}Literature Card"
				}
			},
			c_chm_letter = {
				name = "Letter",
				text = {
					"Remove the {C:dark_edition}Edition{} and {C:enhanced}Enhancement{}",
					"from up to {C:attention}#1#{} selected card#<s>1#,",
					"then add random {C:attention}seals{} to each"
				}
			},
			c_chm_man = {
				name = "Man",
				text = {
					"Apply random",
					"{C:attention}Enhancements{} to up",
					"to {C:attention}#1#{} selected cards"
				}
			},
			c_chm_lady = {
				name = "Lady",
				text = {
					"Randomize {C:attention}rank{}",
					"of up to {C:attention}#1#{}",
					"selected cards"
				}
			},
			c_chm_lily = {
				name = "Lily",
				text = {
					"Create a {C:attention}Coupon Tag{}",
					"and a {C:attention}D6 Tag{}"
				}
			},
			c_chm_sun = {
				name = "Sun",
				text = {
					"If {C:attention}#1#{} card is selected, convert them to an {C:attention}Ace{},",
					"if {C:attention}#2#{} cards are selected, convert them {C:attention}2s{},",
					"and if {C:attention}#3#{} cards are selected, convert them {C:attention}3s{}"
				}
			},
			c_chm_moon = {
				name = "Moon",
				text = {
					"Enhances up to {C:attention}#1#",
					"selected card#<s>1# into",
					"{C:attention}Old Cards"
				}
			},
			c_chm_key = {
				name = "Key",
				text = {
					"Enhances {C:attention}#1#",
					"selected card#<s>1# into a",
					"{C:attention}Mechanical Card"
				}
			},
			c_chm_fish = {
				name = "Fish",
				text = {
					"Apply {C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or {C:dark_edition}Polychrome",
					"to a random card in hand",
					"Earn {C:money}$#1#{} for each {C:dark_edition}Foil{} card in deck,",
					"{C:money}$#2#{} for each {C:dark_edition}Holographic{} card in deck,",
					"and {C:money}$#3#{} for each {C:dark_edition}Polychrome{} card in deck",
					"{C:inactive}(Currently {C:money}$#4#{C:inactive}, {C:money}$#5#{C:inactive}, and {C:money}$#6#{C:inactive})"
				}
			},
            c_chm_anchor = {
				name = "Anchor",
				text = {
					"Enhances up to {C:attention}#1#",
					"selected card#<s>1# into",
					"{C:attention}Ricochet Cards"
				}
			},
			c_chm_cross = {
				name = "Cross",
				text = {
					"Create a random {C:green}Uncommon{} {C:attention}Joker",
					"and a random {C:blue}Common{} {C:attention}Joker",
					"{C:inactive}(Must have room)"
				}
			},
        },
		Enhanced = {
			m_chm_doodle = {
				name = "Doodle",
				text = {
					"{C:green}#1# in #2#{} chance to give {C:red}+4{} Mult",
					"{C:green}#1# in #2#{} chance to give {C:blue}+30{} Chips",
					"{C:green}#1# in #2#{} chance to give {X:red,C:white}X2{} Mult",
					"{C:green}#1# in #2#{} chance to earn {C:money}+$3",
				}
			},
			m_chm_literature = {
				name = "Literature",
				text = {
					"No rank or suit",
					"{C:blue}+#1#{} Chips when held in hand",
					"Increases by {C:chips}+#2#{} Chips",
					"when {C:attention}discarded"
				}
			},
			m_chm_mechanical = {
				name = "Mechanical",
				text = {
					"{C:white,X:mult}X#1#{} Mult",
					"Increases by {C:white,X:mult}X#2#{} Mult when discarded",
					"Resets after hand played"
				}
			},
			m_chm_old = {
				name = "Old",
				text = {
					"Levels up a random",
					"{C:attention}poker hand{} by {C:attention}2{} levels",
					"when {C:attention}discarded"
				}
			},
			m_chm_overgrown = {
				name = "Overgrown",
				text = {
					"{C:blue}+#1#{} Chip#<s>1#{}"
				}
			},
			m_chm_ricochet = {
				name = "Ricochet",
				text = {
					"{C:chips}+#1#{} Chips every {C:attention}#2# {C:inactive}(#3#){} times discarded or scored",
					"{C:mult}+#4#{} Mult every {C:attention}#5# {C:inactive}(#6#){} times discarded or scored",
					"{C:money}+$#7#{} every {C:attention}#8# {C:inactive}(#9#){} times discarded or scored",
					"{C:white,X:mult}X#10#{} Mult every {C:attention}#11# {C:inactive}(#12#){} times discarded or scored"
				}
			},
			m_chm_rotten = {
				name = "Rotten",
				text = {
					"{X:red,C:white}X1.75{} Mult",
					"{C:red}-$3{} when scored"
				}
			},
			m_chm_vine = {
				name = "Vine",
				text = {
					"Retrigger this card {C:attention}once{} for",
					"each free consumable slot",
					"{C:green}#1# in #2# {}chance of becoming an",
					"{C:attention}Overgrown Card{} when scored"
				}
			}
		},
		Other = {
			p_chm_lenormand_pack = {
				name = "Lenormand Pack",
				text = {
					"Choose {C:attention}1{} of up to",
					"{C:attention}2{} {C:lenormand}Lenormand{} cards to",
					"be used immediately"
				}
			},
			p_chm_jumbo_lenormand_pack = {
				name = "Jumbo Lenormand Pack",
				text = {
					"Choose {C:attention}1{} of up to",
					"{C:attention}4{} {C:lenormand}Lenormand{} cards to",
					"be used immediately"
				}
			},
			p_chm_mega_lenormand_pack = {
				name = "Mega Lenormand Pack",
				text = {
					"Choose {C:attention}2{} of up to",
					"{C:attention}4{} {C:lenormand}Lenormand{} cards to",
					"be used immediately"
				}
			}
		}
	},
	misc = {
		dictionary = {
			lenormand = "Lenormand Pack",
			b_lenormand_cards = "Lenormand Cards",
			k_lenormand = "Lenormand",
		}
	}
}