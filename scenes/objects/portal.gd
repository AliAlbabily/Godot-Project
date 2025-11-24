extends Node2D

func _ready():
	visible = false
	
	# Start the animation
	$AnimatedSprite2D.play()
