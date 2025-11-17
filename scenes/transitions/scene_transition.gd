extends CanvasLayer

func change_scene(target: String) -> void:
	print($AnimationPlayer)  # should print the AnimationPlayer node, not null
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished  # waits for the animation to finish

	get_tree().change_scene_to_file(target)

	$AnimationPlayer.play("dissolve", -1.0, -1.0)  # play backwards
	await $AnimationPlayer.animation_finished
