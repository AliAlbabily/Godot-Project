extends Node
class_name PlayerStats

@export_group("Base Stats")
@export var player_name: String = "Player"
@export var max_health: int = 150

func _to_string() -> String:
	return player_name
