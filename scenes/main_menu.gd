extends Control

@onready var main_menu_music: AudioStreamPlayer = $MainMenuMusic
@onready var toggle_music_track: Button = $ToggleMusicTrack
@onready var slideshow: TextureRect = $SlideShow
@onready var fade_overlay: ColorRect = $SlideShow/FadeOverlay
@onready var continue_button: Button = $VBoxContainer/continue

@onready var save_warning_dialog: ConfirmationDialog = $SaveWarningDialog

var music_on_icon: Texture2D = preload("res://art/icons/volume_on.png")
var music_off_icon: Texture2D = preload("res://art/icons/volume_off.png")

var music_playing: bool = true

# Background images
var images: Array[Texture2D] = [
	preload("res://art/images/ninja.png"),
	preload("res://art/images/samurai.png"),
	preload("res://art/images/dragon.png"),
	preload("res://art/images/warrior.png"),
]

var current_index: int = -1
var fade_time: float = 1.5
var display_time: float = 3.0

func _ready() -> void:
	# handle music button
	toggle_music_track.icon = music_on_icon
	main_menu_music.play()
	
	# check the save file & handle continue button
	SaveManager.testing_func_check_save_file()
	continue_button.disabled = !SaveManager.check_save_file() # enable "continue" button if the save file exists
	
	# Start the slideshow asynchronously
	run_slideshow()
	
# slideshow logic
func run_slideshow() -> void:
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

func _on_start_pressed() -> void:
	if SaveManager.check_save_file():
		# if a save exists, show the popup centered on screen
		save_warning_dialog.popup_centered()
	else:
		# No save exists, safe to start immediately
		confirm_new_game()

func _on_continue_pressed() -> void:
	print("continue")
	SaveManager.load_into_session() # Load file into the Autoload
	go_to_next_scene()

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
	var target_scene = SaveManager.current_data["level_path"]
	get_tree().change_scene_to_file(target_scene)

# Testing function
# Press 'Tab key' on the main menu to wipe the save (Debug only!)
func _input(event: InputEvent) -> void:
	if OS.is_debug_build() and event.is_action_pressed("ui_focus_next"):
		DirAccess.remove_absolute("user://variable.save")
		get_tree().reload_current_scene() 
		print("Save wiped for testing!")
		
# a shared function to handle the actual start "New Game" logic
func confirm_new_game() -> void:
	SaveManager.prepare_new_game() # Set up fresh data in the Autoload
	go_to_next_scene()             # Transition to the level
	
# handle the "OK/Yes" click from the popup/ConfirmationDialog
func _on_save_warning_dialog_confirmed() -> void:
	confirm_new_game()
