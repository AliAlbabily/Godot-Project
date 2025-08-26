extends Control

@onready var main_menu_music: AudioStreamPlayer = $MainMenuMusic
@onready var toggle_music_track: Button = $ToggleMusicTrack
@onready var slideshow: TextureRect = $SlideShow
@onready var fade_overlay: ColorRect = $SlideShow/FadeOverlay

var music_on_icon: Texture2D = preload("res://icons/volume_on.png")
var music_off_icon: Texture2D = preload("res://icons/volume_off.png")

var music_playing: bool = true

# Background images
var images: Array[Texture2D] = [
	preload("res://images/ninja.png"),
	preload("res://images/samurai.png"),
	preload("res://images/dragon.png"),
	preload("res://images/warrior.png"),
]

var current_index: int = -1
var fade_time: float = 1.5
var display_time: float = 3.0

func _ready() -> void:
	print("Main_Menu scene ready")
	queue_redraw()
	resized.connect(func(): queue_redraw())  # redraw when the node is resized
	toggle_music_track.icon = music_on_icon
	main_menu_music.play()
	
	# Start slideshow coroutine
	_start_slideshow()
	
	# Start the animation
	$AnimatedSprite2D.play()
	
# Slideshow logic
func _start_slideshow() -> void:
	# Launch async slideshow loop
	start_slideshow()
	
@rpc("call_local") # optional, if networked
func start_slideshow() -> void:
	# Run slideshow asynchronously
	_run_slideshow()
	
func _run_slideshow() -> void:
	await get_tree().create_timer(3.0).timeout  # Initial delay before first image

	while true:
		for i in range(images.size()):
			current_index = i
			slideshow.texture = images[i]
			# Fade in
			await _fade_overlay(0.0, fade_time)
			# Wait visible
			await get_tree().create_timer(display_time).timeout
			# Fade out
			await _fade_overlay(1.0, fade_time)

		# At end → fade to black and hold for 3 seconds
		await get_tree().create_timer(3.0).timeout


# Fade helper
func _fade_overlay(to_alpha: float, duration: float) -> void:
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(fade_overlay, "modulate:a", to_alpha, duration)
	await tween.finished
	
func _exit_tree() -> void:
	print("Main_Menu scene freed")

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), Color.BLACK, true)

func _process(delta):
	pass

func _on_start_pressed() -> void:
	go_to_next_scene()

func _on_continue_pressed() -> void:
	print("continue")

func _on_about_pressed() -> void:
	print("about")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_toggle_music_track_pressed() -> void:
	music_playing = !music_playing
	
	if music_playing:
		main_menu_music.stream_paused = false # ▶ resume
		toggle_music_track.icon = music_on_icon
	else:
		main_menu_music.stream_paused = true   # ⏸ pause
		toggle_music_track.icon = music_off_icon
		
func play_fade_out_animation():
	$FadeLayer/ColorRect.mouse_filter = Control.MOUSE_FILTER_STOP # disable mouse clicks
	$FadeLayer/fade_out.play("fade_out")
	await $FadeLayer/fade_out.animation_finished
		
func go_to_next_scene():
	await play_fade_out_animation()
	get_tree().change_scene_to_file("res://main_scene.tscn")
