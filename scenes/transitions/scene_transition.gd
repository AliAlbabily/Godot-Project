extends CanvasLayer

var is_busy := false

var _load_start_time := 0.0

func change_scene(target: String) -> void:
	if is_busy:
		return
	is_busy = true

	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished  # waits for the animation to finish

	start_benchmark() # test speed
	get_tree().change_scene_to_file(target)

	$AnimationPlayer.play_backwards("dissolve")  # play backwards
	await $AnimationPlayer.animation_finished

	is_busy = false


# Testing function
## Call this right before changing the scene
func start_benchmark() -> void:
	_load_start_time = Time.get_ticks_msec()


# Testing function
## Call this inside the _ready() function of your new level
func end_benchmark(scene_name: String) -> void:
	var duration := Time.get_ticks_msec() - _load_start_time
	
	var performance_rating := "GOOD"
	if duration > 100.0: # 100ms threshold (approx. 6 frames at 60fps)
		performance_rating = "POOR (Potential stutter)"
		
	print("--- PERFORMANCE REPORT ---")
	print("Scene: ", scene_name)
	print("Load Time: ", duration, " ms")
	print("Rating: ", performance_rating)
	print("--------------------------")
