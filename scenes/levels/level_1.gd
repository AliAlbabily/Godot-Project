extends Node2D

var dialogue_activated = false
@onready var portal_appears: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var portal_animation_player: AnimationPlayer = $Portal/AnimationPlayer
@onready var current_background_placeholder: Sprite2D = $Level1Background

func _on_portal_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		SceneTransition.change_scene('res://scenes/battle_prototype.tscn')
		
func use_dialogue():
	var dialogue = get_node("Dialogue")
	
	if dialogue:
		dialogue.start()


func _on_dialogue_dialogue_finished() -> void:
	$Portal.visible = true
	play_portal_sound_effect()
	play_portal_animations()
	
func play_portal_sound_effect():
	portal_appears.play()
	
func play_portal_animations():
	portal_animation_player.play("portal_animations")

func _on_mysterious_man_zoomed_in_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if !dialogue_activated:
			use_dialogue()
			dialogue_activated = true

func _on_mysterious_man_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		LevelUtils.set_background(
			current_background_placeholder,
			"res://images/level1_images/castle-corridor-zoomed-in.jpg"
		)

		var characterInNormalSize = get_node("MysteriousMan")
		var characterZoomedIn = get_node("MysteriousManZoomedIn")
		LevelUtils.character_switch(characterInNormalSize, characterZoomedIn)
