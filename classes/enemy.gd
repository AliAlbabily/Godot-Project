extends Resource
class_name Enemy

@export_group("Base Stats")
@export var enemy_name: String = "Generic Enemy"
@export var max_health: int = 100:
	set(value):
		max_health = value
		enemy_hp = value
var enemy_hp: int = 0

@export_group("Combat Cycle")
## The sequential list of actions the enemy will take. 
## Once it reaches the end, it will loop back to the beginning.
@export var action_cycle: Array[CharacterAction] = []

# Helper function to easily get the correct action based on the turn number
## returns an enemy action
func get_action(turn_index: int) -> CharacterAction:
	if action_cycle.is_empty():
		push_error("EnemyStats: action_cycle is empty for " + enemy_name)
		return null
		
	# The modulo operator (%) perfectly loops the index back to 0 
	# when the turn_index exceeds the array size!
	var looped_index = turn_index % action_cycle.size()
	return action_cycle[looped_index]
	
func get_hp() -> int:
	return enemy_hp
	
func set_hp(value: int) -> void:
	enemy_hp = max(0, value) # prevent negative values
	
func take_damage(amount: int) -> void:
	var remaining_enemy_hp = enemy_hp - amount
	set_hp(remaining_enemy_hp)
	
func get_final_damage(action_damage_points: int) -> int:
	return action_damage_points
	
func get_final_defense(action_defense_points: int) -> int:
	return action_defense_points
	
func _to_string() -> String:
	return enemy_name
