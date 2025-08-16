extends Control

func _ready() -> void:
	queue_redraw()
	resized.connect(func(): queue_redraw())  # redraw when the node is resized

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), Color.BLACK, true)
