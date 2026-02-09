extends Area2D

# This allows you to drag and drop your .tres file in the Inspector
@export var stats: EnemyStats

func _ready():
	if stats:
		print("I am a " + stats.enemy_name)
		print("My health is: ", stats.max_health)
