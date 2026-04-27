class_name CombatLogic

static func execute_action(action: CharacterAction, attacker, defender) -> String:
	var result_text = ""
	
	print(attacker, " is the Attacker & will use : ", action.action_name)
	
	match action.type:
		CharacterAction.ActionType.ATTACK:
			# TODO: For testing purposes, delete later
			if (action.action_name == "Basic Attack"):
				print(action.action_name, " was used")
			else:
				print("Another type of Attack was used")
			# ///////
			var final_dmg = attacker.get_final_damage(action.damage)
			defender.take_damage(final_dmg)
			result_text = "%s deals %d damage!" % [attacker, final_dmg]
			
		#CharacterAction.ActionType.HEAL:
			#attacker.set_player_hp(attacker.get_player_hp() + action.heal)
			#result_text = "%s heals for %d!" % [attacker, action.heal]
			
		# Add other logic (MULTI_ATTACK, BUFFS) here
			
	return result_text
