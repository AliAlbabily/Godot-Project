extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_mouse_entered() -> void:
	# Lighten the image by increasing brightness (modulate makes it brighter)
	sprite_2d.modulate = Color(1.2, 1.2, 1.2, 1.0)  # RGB > 1 makes it lighter

func _on_mouse_exited() -> void:
	# Restore original color
	sprite_2d.modulate = Color(1, 1, 1, 1)  # Original color (no tint)
