extends Node

const SAVE_PATH := "user://variable.save"

# Default data structure for a new game
var default_data = {
	"level_path": "res://scenes/levels/level1.tscn",
	"score": 0,
	"unlocked_items": []
}

# This holds the data for the CURRENT game session
# Start with a copy of the default_data immediately.
var current_data: Dictionary = default_data.duplicate(true)


# Testing function
# Checks for a save file and reads its contents if it exists
func testing_func_check_save_file() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found at: ", SAVE_PATH)
		return
		
	print("Save file EXISTS at: ", SAVE_PATH)
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		print("Failed to open save file at: ", SAVE_PATH)
		return
	
	var saved_value = file.get_var()
	file.close() # Always good practice to close the file stream
	
	print("Saved value is: ", saved_value)


# check if the save file exists on the given path
func check_save_file() -> bool:
	if FileAccess.file_exists(SAVE_PATH):
		return true # return true if the save file exists
	else:
		return false


func create_new_save() -> void:
	# Overwrite the existing file with default data
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(current_data)
		file.close()
		print("New game file created/overwritten.")


func prepare_new_game():
	current_data = default_data.duplicate(true)


func load_into_session() -> void:
	var save_file_exists = check_save_file()
	if save_file_exists:
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		current_data = file.get_var()
		print("Loaded!")
		print(current_data)
		file.close()
	else:
		print("No data saved to be loaded..")
		print("Preparing a new game")
		prepare_new_game()
