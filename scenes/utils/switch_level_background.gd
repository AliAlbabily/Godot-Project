extends Node

func set_background(sprite: Sprite2D, texture_path: String) -> void:
	sprite.texture = load(texture_path)
