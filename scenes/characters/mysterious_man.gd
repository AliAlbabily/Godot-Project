extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_mouse_entered() -> void:
	# Lighten the image by increasing brightness (modulate makes it brighter)
	sprite_2d.modulate = Color(1.2, 1.2, 1.2, 1.0)  # RGB > 1 makes it lighter

func _on_mouse_exited() -> void:
	# Restore original color
	sprite_2d.modulate = Color(1, 1, 1, 1)  # Original color (no tint)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		use_dialogue()

func use_dialogue():
	var dialogue = get_parent().get_node("CanvasLayer/Dialogue")
	
	if dialogue:
		dialogue.start()
