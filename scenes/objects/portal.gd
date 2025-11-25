extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	visible = false
	
	# Start the animation
	$AnimatedSprite2D.play()

func _on_mouse_entered() -> void:
	# Lighten the image by increasing brightness (modulate makes it brighter)
	animated_sprite_2d.modulate = Color(1.2, 1.2, 1.2, 1.0)  # RGB > 1 makes it lighter

func _on_mouse_exited() -> void:
	# Restore original color
	animated_sprite_2d.modulate = Color(1, 1, 1, 1)  # Original color (no tint)
	
