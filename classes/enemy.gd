extends Resource
class_name Enemy

@export_group("Base Stats")
@export var enemy_name: String = "Generic Enemy"
@export var max_health: int = 100

@export_group("Combat Cycle")
## The sequential list of actions the enemy will take. 
## Once it reaches the end, it will loop back to the beginning.
@export var action_cycle: Array[CharacterAction] = []

func _to_string() -> String:
	return enemy_name

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
