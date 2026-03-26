extends Resource
class_name Player

@export_group("Base Stats")
@export var player_name: String = "Player 1"
@export var max_health: int = 150

var current_health: int = max_health
var skills: Array[String] = []
var equipment: Array[String] = []

func add_skill(skill: String) -> void:
	if skill not in skills:
		skills.append(skill)

func add_item(item: String) -> void:
	equipment.append(item)

func _to_string() -> String:
	return player_name
