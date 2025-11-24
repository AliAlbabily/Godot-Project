extends Node

@export_file("*.json") var d_file # to access a json file
var dialogue = []
var current_dialogue_id = 0
var d_active = false

func _ready():
	$NinePatchRect.visible = false
	
func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()
	
func load_dialogue():
	var file = FileAccess.open(d_file, FileAccess.READ)  # Changed to FileAccess
	if file:  # Check if file opened successfully
		var content = file.get_as_text()
		file.close()  # Close the file
		return JSON.parse_string(content)  # Changed to parse_string
	return []  # Return empty array if failed
	
func _input(event):
	if not d_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()
			
func next_script():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogue):
		d_active = false
		$NinePatchRect.visible = false
		return
	
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/Chat.text = dialogue[current_dialogue_id]['text']
