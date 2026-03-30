class_name Player

@export_group("Base Stats")
@export var player_name: String = "Player 1"
@export var max_player_hp: int = 21

# Base Stats
var player_hp: int = max_player_hp
var damage: int = 0
var defense: int = 0
var heal: int = 0

# The Current Build
var current_build: PlayerBuild

var equipment: Array[String] = []

func get_player_hp() -> int:
	return player_hp

func add_item(item: String) -> void:
	equipment.append(item)
	
func take_damage(amount: int) -> void:
	player_hp -= amount

func _to_string() -> String:
	return player_name
