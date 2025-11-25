extends Node2D

var dialogue_activated = false
@onready var portal_appears: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_mysterious_man_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if !dialogue_activated:
			use_dialogue()
			dialogue_activated = true
			#SceneTransition.change_scene('res://scenes/battle_prototype.tscn')
		
func use_dialogue():
	var dialogue = get_node("CanvasLayer/Dialogue")
	
	if dialogue:
		dialogue.start()


func _on_dialogue_dialogue_finished() -> void:
	$Portal.visible = true
	play_portal_sound_effect()
	
func play_portal_sound_effect():
	portal_appears.play()
