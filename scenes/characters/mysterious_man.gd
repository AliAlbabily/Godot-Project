extends Area2D

@onready var tooltip: Label = $Tooltip
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	tooltip.visible = false
	tooltip.text = "Speak with ??"

func _process(_delta: float) -> void:
	if tooltip.visible:
		tooltip.global_position = get_global_mouse_position() + Vector2(12, 12)

func _on_mouse_entered() -> void:
	tooltip.visible = true
	
	# Lighten the image by increasing brightness (modulate makes it brighter)
	sprite_2d.modulate = Color(1.2, 1.2, 1.2, 1.0)  # RGB > 1 makes it lighter

func _on_mouse_exited() -> void:
	tooltip.visible = false
	
	# Restore original color
	sprite_2d.modulate = Color(1, 1, 1, 1)  # Original color (no tint)
