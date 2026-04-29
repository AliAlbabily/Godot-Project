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

var current_turn : Turn = Turn.PLAYER
var battle_over := false
var enemy_turn_index: int = 0
var previous_character_action: CharacterAction = null

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
	update_previous_character_action(null)
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
	
	info_label.text = CombatLogic.execute_action(player_action, previous_character_action, player, current_enemy)
	update_previous_character_action(player_action) # should always execute after CombatLogic.execute_action()
	
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
		
	info_label.text = CombatLogic.execute_action(enemy_action, previous_character_action, current_enemy, player)
	update_previous_character_action(enemy_action) # should always execute after CombatLogic.execute_action()
	
	# Move to next turn
	enemy_turn_index += 1
	
	switch_turn()

# -------- FLOW --------

func switch_turn():
	update_ui()
	check_battle()
	end_turn()

func update_ui():
	player_label.text = "Player HP: %d" % player.get_hp()
	enemy_label.text = "Enemy HP: %d" % current_enemy.get_hp()

func end_turn():
	if battle_over:
		return
		
	current_turn = Turn.ENEMY if current_turn == Turn.PLAYER else Turn.PLAYER
	await get_tree().create_timer(1.5).timeout
	start_turn()

func check_battle():
	if player.get_hp() <= 0:
		info_label.text = "You Lose!"
		battle_over = true
		attack_button.disabled = true
	elif current_enemy.get_hp() <= 0:
		info_label.text = "You Win!"
		battle_over = true
		attack_button.disabled = true
		
func update_previous_character_action(action : CharacterAction):
	previous_character_action = action
