extends CanvasLayer

var is_busy := false

func change_scene(target: String) -> void:
	if is_busy:
		return
	is_busy = true

	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished  # waits for the animation to finish

	get_tree().change_scene_to_file(target)

	$AnimationPlayer.play_backwards("dissolve")  # play backwards
	await $AnimationPlayer.animation_finished

	is_busy = false
