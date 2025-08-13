extends Area2D

var clicked_once = false
@onready var sprite = $CharacterSprite  # Get the Sprite2D node
@onready var new_skill_sound_effect: AudioStreamPlayer = $"../../NewSkillSoundEffect"

func _ready():
	# Enable input pickable
	input_pickable = true
	position = Vector2(740, 230)  # starting position
	

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if not clicked_once:
			play_special_effects()
			clicked_once = true
			
func play_sound_effect():
	new_skill_sound_effect.play()

func show_glitchy_background():
	$"../../Animated_Background".visible = true
	await get_tree().create_timer(8.0).timeout # Make background disappear after 8 seconds
	$"../../Animated_Background".visible = false
	
func play_special_effects():
	show_glitchy_background()
	play_sound_effect()

func _on_mouse_entered() -> void:
	# Lighten the image by increasing brightness (modulate makes it brighter)
	sprite.modulate = Color(1.2, 1.2, 1.2, 1.0)  # RGB > 1 makes it lighter

func _on_mouse_exited() -> void:
	# Restore original color
	sprite.modulate = Color(1, 1, 1, 1)  # Original color (no tint)
