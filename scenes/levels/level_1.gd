extends Node2D

var dialogue_activated = false
@onready var portal_appears: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var portal_animation_player: AnimationPlayer = $Portal/AnimationPlayer
@onready var current_background_placeholder: Sprite2D = $Level1Background
@onready var characterInNormalSize = get_node("MysteriousMan")
@onready var characterZoomedIn = get_node("MysteriousManZoomedIn")

func _on_portal_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		SceneTransition.change_scene('res://scenes/test_files/battle_prototype.tscn')
		
func use_dialogue():
	var dialogue = get_node("Dialogue")
	
	if dialogue:
		dialogue.start()
	
func play_portal_sound_effect():
	portal_appears.play()
	
func play_portal_animations():
	portal_animation_player.play("portal_animations")
	
func disable_mouse_temporarily():
	# Hide the cursor and ignore all mouse clicks/movement globally
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# Wait for 2 seconds
	await get_tree().create_timer(2.0).timeout
	# Show the cursor and re-enable clicks
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_mysterious_man_zoomed_in_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if !dialogue_activated:
			use_dialogue()
			dialogue_activated = true

func _on_mysterious_man_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		LevelUtils.adjust_page_zooming(
			current_background_placeholder,
			"res://art/images/level1_images/castle-corridor-zoomed-in.jpg",
			characterInNormalSize,
			characterZoomedIn
		)

func _on_dialogue_finished() -> void:
	$Portal.visible = true
	play_portal_sound_effect()
	play_portal_animations()
	LevelUtils.adjust_page_zooming(
		current_background_placeholder,
		"res://art/images/level1_images/castle-corridor.jpg",
		characterZoomedIn,
		characterInNormalSize
	)
	disable_mouse_temporarily()
	characterInNormalSize.trigger_fade_effect()
