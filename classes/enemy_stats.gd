extends Resource
class_name EnemyStats

@export_group("Base Stats")
@export var enemy_name: String = "Generic Enemy"
@export var max_health: int = 100

@export_group("Combat")
@export var attack_damage: int = 10
@export var defense: int = 5

func _to_string() -> String:
	return enemy_name
