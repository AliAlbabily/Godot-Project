extends Node

func _ready() -> void:
	print("Main_Testing scene ready")

func _exit_tree() -> void:
	print("Main_Testing scene freed")
