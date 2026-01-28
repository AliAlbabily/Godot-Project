extends Node

func set_background(sprite: Sprite2D, texture_path: String) -> void:
	sprite.texture = load(texture_path)
	
## Switches which character is visible by hiding one node and showing another
func character_switch(node_to_hide: Node, node_to_display: Node) -> void:
	if node_to_hide:
		node_to_hide.visible = false

	if node_to_display:
		node_to_display.visible = true
		
func adjust_page_zooming(current_sprite: Sprite2D, texture_path: String, node_to_hide: Node, node_to_display: Node):
	set_background(current_sprite, texture_path)
	character_switch(node_to_hide, node_to_display)
