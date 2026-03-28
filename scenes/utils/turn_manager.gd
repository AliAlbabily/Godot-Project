extends Node

# A custom object to hold the UI references
class BattleUI extends RefCounted:
	var player_label: Label
	var enemy_label: Label
	var info_label: Label
	var attack_button: Button

enum Turn { PLAYER, ENEMY }

@onready var player = Game.player
var current_enemy_stats : EnemyStats

var enemy_hp: int = 0

var current_turn : Turn = Turn.PLAYER
var battle_over := false
var enemy_turn_index: int = 0

var player_label: Label
var enemy_label: Label
var info_label: Label
var attack_button: Button

func setup_battle(enemy_data: EnemyStats, ui: BattleUI) -> void:
	# Assign variables
	info_label = ui.info_label
	player_label = ui.player_label
	enemy_label = ui.enemy_label
	attack_button = ui.attack_button
	
	current_enemy_stats = enemy_data
	
	# 1. Reset state variables
	info_label.text = "Battle Started!"
	battle_over = false
	current_turn = Turn.PLAYER
	
	# 2. Reset Stats
	enemy_hp = enemy_data.max_health
	enemy_turn_index = 0
	
	# 3. Refresh UI
	print("Enemy " + enemy_data.enemy_name + " appears!")
	update_ui()
	attack_button.disabled = false
	
	# 4. Start
	start_turn()


func update_ui():
	player_label.text = "Player HP: %d" % player.get_player_hp()
	enemy_label.text = "Enemy HP: %d" % enemy_hp


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

func player_attack():
	if current_turn != Turn.PLAYER:
		return
	
	#################################
	# TODO: change the random attack to a specific one
	var dmg = randi_range(4, 8)
	
	#################################
	enemy_hp -= dmg
	info_label.text = "You hit for %d!" % dmg
	update_ui()
	check_battle()
	end_turn()

# -------- ENEMY --------

func enemy_turn():
	# simple delay "animation"
	await get_tree().create_timer(1.5).timeout
	
	# enemy attacks logic
	var enemy_action = current_enemy_stats.get_action(enemy_turn_index)
	
	if enemy_action == null:
		push_error("No more actions to take")
		return
		
	match enemy_action.type:
		EnemyAction.ActionType.ATTACK:
			player.take_damage(enemy_action.damage)
			info_label.text = "%s hits for %d!" % [current_enemy_stats.enemy_name, enemy_action.damage]
		
		EnemyAction.ActionType.DEFEND:
			info_label.text = "%s defends for %d!" % [current_enemy_stats.enemy_name, enemy_action.defense]
		
		#EnemyAction.ActionType.HEAL:
			#info_label.text = "%s heals for %d!" % [current_enemy_stats.enemy_name, enemy_action.heal]
		#
		#EnemyAction.ActionType.MULTI_ATTACK:
			#var total_damage = enemy_action.damage * enemy_action.multi_hit_count
			#player_hp -= total_damage
			#info_label.text = "%s hits %d times for %d total!" % [
				#current_enemy_stats.enemy_name,
				#enemy_action.multi_hit_count,
				#total_damage
			#]

	# Move to next turn
	enemy_turn_index += 1
	
	update_ui()
	check_battle()
	end_turn()

# -------- FLOW --------

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
