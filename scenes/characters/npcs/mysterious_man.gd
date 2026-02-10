extends Area2D

@onready var tooltip: Label = $Tooltip
@onready var sprite_2d: Sprite2D = $Sprite2D

var move_distance: float = 50.0  # How far left to move (pixels)
var duration: float = 2.0        # How long the effect takes (seconds)

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

## ghostly move the character then delete it after the animation finishes
func trigger_fade_effect():
	# Create a tween that binds to this node (or the scene tree)
	var tween = create_tween()

	# Calculate the target position (current position - distance to the left)
	var target_position = position - Vector2(move_distance, 0)

	# 1. Animate Position: Move to target_position
	# set_trans and set_ease make the movement look more natural
	tween.tween_property(self, "position", target_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# 2. Animate Opacity: Fade 'modulate:a' (alpha channel) to 0 simultaneously
	# We use 'parallel()' so this happens at the same time as the movement
	tween.parallel().tween_property(self, "modulate:a", 0.0, duration)

	# 3. Cleanup: Queue free (delete) the character after the animation finishes
	tween.tween_callback(queue_free)
