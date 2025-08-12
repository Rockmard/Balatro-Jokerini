-- ATLAS

SMODS.Atlas({
	key = "purple_ticket",
	path = "j_purple_ticket.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "cigarettes",
	path = "j_cigarettes.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "dawn",
	path = "j_dawn.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "iron_factory",
	path = "j_placeholder.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "iron_man",
	path = "j_iron_man.png",
	px = 71,
	py = 95
})

SMODS.Atlas({
	key = "trade",
	path = "j_trade.png",
	px = 71,
	py = 95
})

-- JOKERS

SMODS.Joker{
	key = "purple_ticket",                               --name used by the joker.    
	config = nil,    						 	         --variables used for abilities and effects.
	pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
	rarity = 2,                                          --rarity 1=common, 2=uncommon, 3=rare, 4=legendary
	cost = 5,                                            --cost to buy the joker in shops.
	blueprint_compat=true,                               --does joker work with blueprint.
	eternal_compat=true,                                 --can joker be eternal.
	unlocked = true,                                     --is joker unlocked by default.
	discovered = true,                                   --is joker discovered by default.    
	effect="Tarot playing purple seal",			 		 --you can specify an effect here eg. 'Mult'
	soul_pos=nil,                                        --pos of a soul sprite.
	atlas = 'purple_ticket',                             --atlas name, single sprites are deprecated.

	calculate = function(self, card, context)                     -- define calculate functions here
		if context.individual and context.cardarea == G.play then -- if we are in card scoring phase, and we are on individual cards
			if context.other_card.seal == 'Purple' then           -- if the card has a purple seal

				randonum = math.random(1, 100)
				if randonum == 1 then                             -- if it's the lucky time (negative tarot)
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.3,
						func = (function()
								local tarot = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'ppt')
								tarot:set_edition({negative = true}, true)
								tarot:add_to_deck()
								G.consumeables:emplace(tarot)
								return true
						end)}))

					return {
						card = card,
						colour = G.C.PURPLE,
						message = localize('k_plus_tarot'), 
					}

				elseif #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then -- if the consumeable space is enough
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						trigger = 'before',
						delay = 0.3,
						func = (function()
								local tarot = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'ppt')
								tarot:add_to_deck()
								G.consumeables:emplace(tarot)
								G.GAME.consumeable_buffer = 0
								return true
						end)}))

					return {
						card = card,
						colour = G.C.PURPLE,
						message = localize('k_plus_tarot'), 
					}
				end
			end
		end
	end,
}

SMODS.Joker{
	key = "cigarettes",                                  
	config = {extra = {Xmult = 5, hands = 3}},    						 	 
	pos = { x = 0, y = 0 },                             
	rarity = 3,                                          
	cost = 8,                                            
	blueprint_compat=true,                               
	eternal_compat=true,                                 
	unlocked = true,                                     
	discovered = true,                                    
	effect="X Mult for hand size",			 		 
	soul_pos=nil,                                        
	atlas = 'cigarettes',                             

	calculate = function(self, card, context)
		if context.joker_main then
			if not context.blueprint then
				card.ability.extra.hands = card.ability.extra.hands - 1

				if card.ability.extra.hands == 0 then
					G.hand:change_size(-1)
					card.ability.extra.hands = 3
				end
			end

			return {
				message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
				Xmult_mod = card.ability.extra.Xmult,
			}
		end
	end,
}

SMODS.Joker{
	key = "dawn",                                  
	config = {extra = 1},    						 	 
	pos = { x = 0, y = 0 },                             
	rarity = 2,                                          
	cost = 4,                                            
	blueprint_compat=true,                               
	eternal_compat=true,                                 
	unlocked = true,                                     
	discovered = true,                                    
	effect="Retrigger first hand",			 		 
	soul_pos=nil,                                        
	atlas = 'dawn',                             

	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra,
				card = card,
			}
		end
	end,
}

SMODS.Joker{
	key = "iron_factory",                                  
	config = nil,  						 	 
	pos = { x = 0, y = 0 },                             
	rarity = 3,                                          
	cost = 9,                                            
	blueprint_compat=true,                               
	eternal_compat=true,                                 
	unlocked = true,                                     
	discovered = true,                                    
	effect="Mult iron card",			 		 
	soul_pos=nil,                                        
	atlas = 'iron_factory',                             

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card.ability.effect == "Steel Card" then
				context.other_card.ability.h_x_mult = context.other_card.ability.h_x_mult + 0.1

				return {
					card = card,
					message = localize('k_upgrade_ex'),
					colour = G.C.MULT,
				}
			end
		end
	end,
}

SMODS.Joker{
	key = "iron_man",                                  
	config = nil,  						 	 
	pos = { x = 0, y = 0 },                             
	rarity = 3,                                          
	cost = 8,                                            
	blueprint_compat=false,                               
	eternal_compat=true,                                 
	unlocked = true,                                     
	discovered = true,                                    
	effect="Make iron card",			 		 
	soul_pos=nil,                                        
	atlas = 'iron_man',                             

	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			local fourty_twos = {}
			for k, v in ipairs(context.scoring_hand) do
				if (v:get_id() == 4 or v:get_id() == 2) and not v.debuff then 
					fourty_twos[#fourty_twos+1] = v
					v:set_ability(G.P_CENTERS.m_steel, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()	
							v:juice_up()
							return true
						end
					}))
				end
			end
			if #fourty_twos > 0 then
				return {
					message = "Steel",
					colour = G.C.GREY,
					card = card
				}
			end
		end
	end,
}

SMODS.Joker{
	key = "trade",                                  
	config = nil,  						 	 
	pos = { x = 0, y = 0 },                             
	rarity = 2,                                          
	cost = 5,                                            
	blueprint_compat=false,                               
	eternal_compat=true,                                 
	unlocked = true,                                     
	discovered = true,                                    
	effect="Trade cards",			 		 
	soul_pos=nil,                                        
	atlas = 'trade',                             

	calculate = function(self, card, context)
		if context.end_of_round and not context.blueprint and not (context.individual or context.repetition) then
			if #G.hand.cards > 1 then

				local card_to_kill = nil
				local place
				for i=1, #G.hand.cards do
                    card_to_kill = G.hand.cards[i]
					place = i
				end

				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function() 
							if card_to_kill.ability.name == 'Glass Card' then 
								card_to_kill:shatter()
							else
								card_to_kill:start_dissolve(nil, i == G.hand.cards[place])
							end
						return true end }))

				delay(0.5)

				local card_to_duplicate = copy_card(G.hand.cards[1], nil, nil, nil)
				card_to_duplicate:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, card_to_duplicate)
				G.hand:emplace(card_to_duplicate)
				card_to_duplicate.states.visible = nil

				G.E_MANAGER:add_event(Event({
					func = function()
						card_to_duplicate:start_materialize()
						return true
					end
				}))
			
				return {
					message = "Trade",
					colour = G.C.IMPORTANT,
					card = card,
				}
			end
			return {
				message = "Not enough card",
				colour = G.C.IMPORTANT,
				card = card,
			}
		end
	end,
}