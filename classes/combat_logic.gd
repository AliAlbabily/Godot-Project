class_name CombatLogic

static func execute_action(action: CharacterAction, previous_character_action: CharacterAction, attacker, defender) -> String:
	var result_text = ""
	
	print(attacker, " is acting & will use : ", action.action_name)
	
	match action.type:
		CharacterAction.ActionType.ATTACK:
			
			# check if the previous action was DEFEND and not null
			if previous_character_action != null and previous_character_action.type == CharacterAction.ActionType.DEFEND:
				
				var defender_defence_points = defender.get_final_defense(previous_character_action.defense)
				var attacker_damage_points = attacker.get_final_damage(action.damage)
			
				print("")
				print("defender_defence_points: ", defender_defence_points)
				print("attacker_damage_points: ", attacker_damage_points)
				print("")
				
				
			else:
				# TODO: For testing purposes, delete later
				if (action.action_name == "Basic Attack"):
					print(action.action_name, " was used")
					print("")
				else:
					print("Another type of Attack was used")
					print("")
				# ///////
				var final_dmg = attacker.get_final_damage(action.damage)
				defender.take_damage(final_dmg)
				result_text = "%s deals %d damage!" % [attacker, final_dmg]
			
		CharacterAction.ActionType.HEAL:
			var healing_points = attacker.increase_hp(action.heal)
			result_text = "%s heals for %d!" % [attacker, healing_points]
			
		# TODO: needs testing
		CharacterAction.ActionType.DEFEND:
			result_text = "%s defends for %d!" % [attacker, action.defense]
			
		# Add other logic (MULTI_ATTACK, BUFFS) here
			
	print("----------------------------------------------------")
	
	return result_text
	
	
	# inside enemy_turn()
	
			#if (latest_player_action == "player_defending"):
				#var player_defence_points = player.player_defense
				#var enemy_dmg_points = current_enemy.get_action(enemy_turn_index).damage
			#
				#if (player_defence_points >= enemy_dmg_points):
					#info_label.text = "Player received 0 dmg"
				#else:
					#var remaining_enemy_dmg_points = enemy_dmg_points - player_defence_points
					#player.take_damage(remaining_enemy_dmg_points)
					#info_label.text = "%s hits for %d!" % [current_enemy.enemy_name, enemy_action.damage]
			#else:
				#player.take_damage(enemy_action.damage)
				#info_label.text = "%s hits for %d!" % [current_enemy.enemy_name, enemy_action.damage]
			#

	# /////////////////////
