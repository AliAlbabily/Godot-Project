extends Node

@export var enemy_data : Enemy

@onready var player_label: Label = $VBoxContainer/PlayerLabel
@onready var enemy_label: Label = $VBoxContainer/EnemyLabel
@onready var info_label: Label = $VBoxContainer/InfoLabel
@onready var attack_button: Button = $VBoxContainer/AttackButton

func _ready() -> void:
	print("level 2 - battle phase scene ready")
	
	# Use TurnManager to access the class definition
	var battle_ui = TurnManager.BattleUI.new()
	
	# Populate the object with your @onready nodes
	battle_ui.player_label = player_label
	battle_ui.enemy_label = enemy_label
	battle_ui.info_label = info_label
	battle_ui.attack_button = attack_button
	
	TurnManager.setup_battle(enemy_data, battle_ui)

func _exit_tree() -> void:
	print("level 2 - battle phase scene freed")
	
func _on_attack_button_pressed() -> void:
	## TODO : In the future, add a paramater for type-of-attack inside player_attack()
	TurnManager.player_attack()

# TODO: For testing purposes, delete later
func _on_add_build_pressed() -> void:
	var tank_build = load("res://Resources/the_tank.tres")
	GameManager.get_player().set_player_build(tank_build)

# TODO: For testing purposes, delete later
func _on_player_info_pressed() -> void:
	GameManager.get_player().print_player_stats()
