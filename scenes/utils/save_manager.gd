extends Node

const SAVE_PATH := "user://variable.save"

# testing function
func test_save_file_exists() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		print("Save file EXISTS at: ", SAVE_PATH)
	else:
		print("No save file found at: ", SAVE_PATH)

# TODO: change the type of data stored in the future
# testing function
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

func save_file_exists() -> bool:
	# return false if a save file exists
	return !FileAccess.file_exists(SAVE_PATH)
