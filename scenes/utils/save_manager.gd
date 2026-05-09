extends Node

# testing function
func test_save_file_exists() -> void:
	var path = "user://variable.save"
	
	if FileAccess.file_exists(path):
		print("Save file EXISTS at: ", path)
	else:
		print("No save file found at: ", path)

# TODO: change the type of data stored in the future
# testing function
func read_save_file() -> int:
	var path = "user://variable.save"
	
	if not FileAccess.file_exists(path):
		print("No save file found at: ", path)
		return 0
	
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		print("Failed to open save file.")
		return 0
	
	var saved_value = file.get_var()
	file.close()
	
	print("Saved value is: ", saved_value)
	return saved_value

func save_file_exists() -> bool:
	# return false if a save file exists
	return !FileAccess.file_exists("user://variable.save")
