extends Node2D

var currentActionStatus : String = ""
var generation : int = 0  # keeps track of the "latest" call

func switch_status(status: String = ""):
	if currentActionStatus == status:
		return

	currentActionStatus = status
	generation += 1  # bump generation whenever status changes
	_delayed_print(status, generation)


func _delayed_print(status: String, my_generation: int) -> void:
	await get_tree().create_timer(1.5).timeout

	# Only print if this is still the latest generation
	if my_generation == generation and currentActionStatus == status:
		print("Status (after 1.5s): ", status)


func _on_attack_mouse_entered() -> void:
	switch_status("attack-enabled")


func _on_defence_mouse_entered() -> void:
	switch_status("defence-enabled")


func _on_attack_mouse_exited() -> void:
	switch_status("attack-disabled")


func _on_defence_mouse_exited() -> void:
	switch_status("defence-disabled")
