extends Control

@onready var main_menu_music: AudioStreamPlayer = $MainMenuMusic
@onready var toggle_music_track: Button = $ToggleMusicTrack

var music_on_icon: Texture2D = preload("res://icons/volume_on.png")
var music_off_icon: Texture2D = preload("res://icons/volume_off.png")

var music_playing: bool = true

func _ready() -> void:
	print("Main_Menu scene ready")
	queue_redraw()
	resized.connect(func(): queue_redraw())  # redraw when the node is resized
	toggle_music_track.icon = music_on_icon
	main_menu_music.play()
	
	# Start the animation
	$AnimatedSprite2D.play()
	
func _exit_tree() -> void:
	print("Main_Menu scene freed")

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, size), Color.BLACK, true)

func _process(delta):
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main_scene.tscn")

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
