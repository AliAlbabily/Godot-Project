extends Node2D


func _on_attack_mouse_entered() -> void:
	print("Attack!")


func _on_defence_mouse_entered() -> void:
	print("Defence!")


func _on_attack_mouse_exited() -> void:
	print("Attack cancelled!")


func _on_defence_mouse_exited() -> void:
	print("Defence cancelled!")
