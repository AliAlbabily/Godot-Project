extends Node2D

const SAVE_PATH := "user://variable.save"

var counter: int = 0

func _ready():
	print(counter)

func save():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(counter)
	print("Saved!")
	
func load_data():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		counter = file.get_var(counter)
		print("Loaded!")
	else:
		print("no data saved..")
		counter = 0

func _on_button_pressed() -> void:
	counter += 1
	print(counter)

func _on_save_pressed() -> void:
	save()

func _on_load_pressed() -> void:
	load_data()

func _on_counter_result_pressed() -> void:
	print("Result = " + str(int(counter)))
