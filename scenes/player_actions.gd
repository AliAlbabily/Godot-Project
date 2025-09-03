extends Node2D

@onready var shield_animations: AnimationPlayer = $"../Shield-cropped/shield_animations"
@onready var sword_animations: AnimationPlayer = $"../Sword-cropped/sword_animations"
@onready var shield_cropped: Sprite2D = $"../Shield-cropped"
@onready var sword_cropped: Sprite2D = $"../Sword-cropped"

var objects: Array = []

		
func _ready():
	objects = [shield_cropped, sword_cropped]
	print(shield_cropped)
	print(sword_cropped)
	
func is_sprite_visible(sprite: Sprite2D) -> bool:
	if not sprite:
		return false
	var notifier: VisibleOnScreenNotifier2D = sprite.get_node_or_null("VisibleOnScreenNotifier2D")
	if notifier and notifier.is_on_screen():
		return true
	return false


func _on_attack_mouse_entered() -> void:
	for obj in objects:
		#TODO: ################
		if (obj == sword_cropped):
			if is_sprite_visible(obj):
				print(obj, " is visible on the field") # replace with a "return" later
			else:
				print(obj, " is off screen")
				sword_animations.play("slide_in")
	

func _on_defence_mouse_entered() -> void:
	for obj in objects:
		#TODO: ################
		if (obj == shield_cropped):
			if is_sprite_visible(obj):
				print(obj, " is visible on the field") # replace with a "return" later
			else:
				print(obj, " is off screen")
				shield_animations.play("slide_in")


func _on_attack_mouse_exited() -> void:
	pass


func _on_defence_mouse_exited() -> void:
	#shield_animations.play("slide_out")
	pass
