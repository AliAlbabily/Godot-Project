class_name CombatLogic

static func execute_action(action: CharacterAction, attacker, defender) -> String:
	var result_text = ""
	
	match action.type:
		CharacterAction.ActionType.ATTACK:
			pass
			#var final_dmg = action.damage
			#if is_defending:
				#final_dmg = max(0, action.damage - defender.player_defense)
			#
			#defender.take_damage(final_dmg)
			#result_text = "%s deals %d damage!" % [attacker, final_dmg]
			
		#CharacterAction.ActionType.HEAL:
			#attacker.set_player_hp(attacker.get_player_hp() + action.heal)
			#result_text = "%s heals for %d!" % [attacker, action.heal]
			
		# Add other logic (MULTI_ATTACK, BUFFS) here
			
	return result_text
