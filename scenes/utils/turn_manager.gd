extends Node

# A custom object to hold the UI references
class BattleUI extends RefCounted:
	var player_label: Label
	var enemy_label: Label
	var info_label: Label
	var attack_button: Button

enum Turn { PLAYER, ENEMY }

@onready var player = GameManager.get_player()
var current_enemy : Enemy

var enemy_hp: int = 0

var current_turn : Turn = Turn.PLAYER
var battle_over := false
var enemy_turn_index: int = 0
var selected_player_action: String = ""

var player_label: Label
var enemy_label: Label
var info_label: Label
var attack_button: Button

func setup_battle(new_enemy: Enemy, ui: BattleUI) -> void:
	# Assign variables
	info_label = ui.info_label
	player_label = ui.player_label
	enemy_label = ui.enemy_label
	attack_button = ui.attack_button
	
	# Assign a new enemy
	current_enemy = new_enemy
	
	# 1. Reset state variables
	info_label.text = "Battle Started!"
	battle_over = false
	current_turn = Turn.PLAYER
	update_selected_player_action("")
	enemy_hp = new_enemy.max_health
	enemy_turn_index = 0
	
	# 2. Refresh UI
	print("Enemy " + new_enemy.enemy_name + " appears!")
	update_ui()
	attack_button.disabled = false
	
	# 3. Start
	start_turn()

func start_turn():
	if battle_over:
		return

	match current_turn:
		Turn.PLAYER:
			info_label.text = "Your turn"
			attack_button.disabled = false
		Turn.ENEMY:
			info_label.text = "Enemy thinking..."
			attack_button.disabled = true
			enemy_turn()

# -------- PLAYER --------

func player_turn(player_action : CharacterAction):
	if current_turn != Turn.PLAYER:
		return
	
	info_label.text = CombatLogic.execute_action(player_action, player, current_enemy)
	
	# TODO: this code will be replaced by CombatLogic.execute_action()
	match player_action:
		"normal-attack":
			var dmg = player.player_damage
			enemy_hp -= dmg
			info_label.text = "You hit for %d!" % dmg
			update_selected_player_action("player_normal_attacks")
		"defend":
			info_label.text = "Player is defending"
			update_selected_player_action("player_defending")
		"heal":
			var healing_points = player.player_heal
			var new_player_hp = player.get_player_hp() + healing_points
			player.set_player_hp(new_player_hp)
			info_label.text = "Player healed by %d points" % healing_points
			update_selected_player_action("player_healing")
	# /////////////////////
	
	switch_turn()

# -------- ENEMY --------

func enemy_turn():
	# simple delay "animation"
	await get_tree().create_timer(1.5).timeout
	
	# gets the current enemy action
	var enemy_action = current_enemy.get_action(enemy_turn_index)
	
	if enemy_action == null:
		push_error("No more actions to take")
		return
		
	info_label.text = CombatLogic.execute_action(enemy_action, current_enemy, player)
	
	# TODO: this code will be replaced by CombatLogic.execute_action()
	match enemy_action.type:
		CharacterAction.ActionType.ATTACK:

			if (selected_player_action == "player_defending"):
				print("player is defending")
				var player_defence_points = player.player_defense
				var enemy_dmg_points = current_enemy.get_action(enemy_turn_index).damage
				print('\n')
				print("Enemy dmg points:", enemy_dmg_points)
				print("Player def points:", player_defence_points)
			
				if (player_defence_points >= enemy_dmg_points):
					print("No dmg was taken..")
					info_label.text = "Player received 0 dmg"
				else:
					print("Player with shield took some dmg!")
					var remaining_enemy_dmg_points = enemy_dmg_points - player_defence_points
					player.take_damage(remaining_enemy_dmg_points)
					info_label.text = "%s hits for %d!" % [current_enemy.enemy_name, enemy_action.damage]
			else:
				print("The enemy makes a direct attack!")
				player.take_damage(enemy_action.damage)
				info_label.text = "%s hits for %d!" % [current_enemy.enemy_name, enemy_action.damage]
			
		
		CharacterAction.ActionType.DEFEND:
			info_label.text = "%s defends for %d!" % [current_enemy.enemy_name, enemy_action.defense]
		
		#EnemyAction.ActionType.HEAL:
			#info_label.text = "%s heals for %d!" % [current_enemy.enemy_name, enemy_action.heal]
		#
		#EnemyAction.ActionType.MULTI_ATTACK:
			#var total_damage = enemy_action.damage * enemy_action.multi_hit_count
			#player_hp -= total_damage
			#info_label.text = "%s hits %d times for %d total!" % [
				#current_enemy.enemy_name,
				#enemy_action.multi_hit_count,
				#total_damage
			#]
	# /////////////////////

	# Move to next turn
	enemy_turn_index += 1
	
	switch_turn()

# -------- FLOW --------

func switch_turn():
	update_ui()
	check_battle()
	end_turn()

func update_ui():
	player_label.text = "Player HP: %d" % player.get_player_hp()
	enemy_label.text = "Enemy HP: %d" % enemy_hp

func end_turn():
	if battle_over:
		return
		
	current_turn = Turn.ENEMY if current_turn == Turn.PLAYER else Turn.PLAYER
	await get_tree().create_timer(1.5).timeout
	start_turn()

func check_battle():
	if player.get_player_hp() <= 0:
		info_label.text = "You Lose!"
		battle_over = true
		attack_button.disabled = true
	elif enemy_hp <= 0:
		info_label.text = "You Win!"
		battle_over = true
		attack_button.disabled = true
		
func update_selected_player_action(selected_action : String):
	selected_player_action = selected_action
