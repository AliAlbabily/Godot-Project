extends Area2D

# This allows you to drag and drop your .tres file in the Inspector
# This is in order to use a resource file
@export var enemy_data: Enemy

func _ready():
	if enemy_data:
		print("I am a " + enemy_data.enemy_name)
		print("My health is: ", enemy_data.max_health)
