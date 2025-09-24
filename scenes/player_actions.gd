extends Node2D

@onready var shield_animations: AnimationPlayer = $"../Shield-cropped/shield_animations"
@onready var sword_animations: AnimationPlayer = $"../Sword-cropped/sword_animations"
@onready var shield_cropped: Sprite2D = $"../Shield-cropped"
@onready var sword_cropped: Sprite2D = $"../Sword-cropped"

var objects: Array = []

var latest_action : Sprite2D = null

@onready var actions_starting_x_positions = {
	shield_cropped: shield_cropped.position.x,
	sword_cropped: sword_cropped.position.x,
}

		
func _ready():
	objects = [shield_cropped, sword_cropped]
	
	#TODO:
	print("shield:", actions_starting_x_positions[shield_cropped])
	print("sword:", actions_starting_x_positions[sword_cropped])
	

func switch_status(previous_action_object: Sprite2D, previous_action: String):
	await get_tree().create_timer(0.50).timeout
	previous_action_object.play(previous_action)
	
	
func is_sprite_visible(sprite: Sprite2D) -> bool:
	if not sprite:
		return false
	var notifier: VisibleOnScreenNotifier2D = sprite.get_node_or_null("VisibleOnScreenNotifier2D")
	if notifier and notifier.is_on_screen():
		return true
	return false


func _on_attack_mouse_entered() -> void:
	if sword_animations.current_animation != "slide_in":
		sword_animations.play("slide_in", 0.1)
	

func _on_defence_mouse_entered() -> void:
	if shield_animations.current_animation != "slide_in":
		shield_animations.play("slide_in", 0.1)

	
func _on_attack_mouse_exited() -> void:
	if sword_animations.current_animation != "slide_out":
		sword_animations.play("slide_out", 0.1)


func _on_defence_mouse_exited() -> void:
	if shield_animations.current_animation != "slide_out":
		shield_animations.play("slide_out", 0.1)


# how to set new position
#shield_cropped.position = Vector2(147, shield_cropped.position.y)
