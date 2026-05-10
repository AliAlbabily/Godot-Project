extends Node

const SAVE_PATH := "user://variable.save"

# Default data structure for a new game
var default_data = {
	"level": 1,
	"health": 100,
	"score": 0,
	"unlocked_items": []
}

# Testing function
# Check if the save file exists
func testing_func_check_save_file() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		print("Save file EXISTS at: ", SAVE_PATH)
	else:
		print("No save file found at: ", SAVE_PATH)


# Testing function
func read_save_file() -> int:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found at: ", SAVE_PATH)
		return 0
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		print("Failed to open save file.")
		return 0
	
	var saved_value = file.get_var()
	file.close()
	
	print("Saved value is: ", saved_value)
	return saved_value


# check if the save file exists on the given path
func check_save_file() -> bool:
	if FileAccess.file_exists(SAVE_PATH):
		return true # return true if the save file exists
	else:
		return false


# TODO: needs testing
func create_new_save() -> void:
	# Overwrite the existing file with default data
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(default_data)
		file.close()
		print("New game file created/overwritten.")


# TODO: needs testing
func load_data() -> void:
	var save_file_exists = check_save_file()
	if save_file_exists:
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		default_data = file.get_var(default_data)
		print("Loaded!")
		print("")
		print(default_data)
	else:
		print("No data saved to be loaded..")
