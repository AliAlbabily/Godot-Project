extends Control

func _ready() -> void:
	print("Main_Menu scene ready")
	queue_redraw()
	resized.connect(func(): queue_redraw())  # redraw when the node is resized
	
func _exit_tree() -> void:
	print("Main_Menu scene freed")

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), Color.BLACK, true)

func _process(delta):
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main_scene.tscn")

func _on_continue_pressed() -> void:
	print("continue")

func _on_about_pressed() -> void:
	print("about")

func _on_quit_pressed() -> void:
	get_tree().quit()
