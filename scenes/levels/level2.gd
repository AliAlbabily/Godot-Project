extends Node

@export var current_enemy_data : EnemyStats

@onready var player_label: Label = $VBoxContainer/PlayerLabel
@onready var enemy_label: Label = $VBoxContainer/EnemyLabel
@onready var info_label: Label = $VBoxContainer/InfoLabel
@onready var attack_button: Button = $VBoxContainer/AttackButton

func _ready() -> void:
	print("battle phase scene ready")
	
	# Use TurnManager to access the class definition
	var battle_ui = TurnManager.BattleUI.new()
	
	# Populate the object with your @onready nodes
	battle_ui.player_label = player_label
	battle_ui.enemy_label = enemy_label
	battle_ui.info_label = info_label
	battle_ui.attack_button = attack_button
	
	TurnManager.setup_battle(current_enemy_data, battle_ui)

func _exit_tree() -> void:
	print("battle phase scene freed")
	
func _on_attack_button_pressed() -> void:
	pass # Replace with function body.
