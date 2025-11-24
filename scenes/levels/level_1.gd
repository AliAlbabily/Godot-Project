extends Node2D

func _on_mysterious_man_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		use_dialogue()
		#SceneTransition.change_scene('res://scenes/battle_prototype.tscn')
		
func use_dialogue():
	var dialogue = get_node("CanvasLayer/Dialogue")
	
	if dialogue:
		dialogue.start()
