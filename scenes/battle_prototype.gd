extends Node2D

func _ready() -> void:
	print("battle phase scene ready")

func _exit_tree() -> void:
	print("battle phase scene freed")
