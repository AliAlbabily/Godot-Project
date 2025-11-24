extends Node2D

func _ready():
	visible = false
	
	# Get the center of the current viewport
	var screen_center = get_viewport_rect().size / 2

	# Center the AnimatedSprite2D
	$BackgroundAnimatedSprite.position = screen_center

	# Center the Label on the same spot as the sprite
	$Label.position = screen_center - ($Label.size / 2)

	# Start the animation
	$BackgroundAnimatedSprite.play()
