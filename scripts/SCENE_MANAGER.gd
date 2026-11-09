extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

var is_transitioning: bool = false


func change_scene(target_scene_path: String, delay: float = 0.2, fade_duration: float = 0.5) -> void:
	if is_transitioning:
		return
	if target_scene_path == "" or not ResourceLoader.exists(target_scene_path):
		push_error("SceneManager: Invalid path -> " + target_scene_path)
		return

	is_transitioning = true

	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP

	if delay > 0.0:
		await get_tree().create_timer(delay).timeout

	var fade_out = create_tween()
	fade_out.tween_property(color_rect, "modulate:a", 1.0, fade_duration)
	await fade_out.finished

	get_tree().change_scene_to_file(target_scene_path)

	var fade_in = create_tween()
	fade_in.tween_property(color_rect, "modulate:a", 0.0, fade_duration)
	await fade_in.finished

	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	is_transitioning = false
