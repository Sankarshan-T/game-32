extends CanvasLayer

@onready var collectible_label: Label = $TextureRect/Label

func _ready() -> void:
	GameState.collectible_count_changed.connect(_on_collectible_count_changed)
	_update_text(GameState.collectibles)

	get_tree().tree_changed.connect(_check_visibility)
	_check_visibility()


func _check_visibility() -> void:
	var current_scene = get_tree().current_scene
	if current_scene == null:
		return

	visible = current_scene is Node2D or current_scene is Node3D


func _on_collectible_count_changed(new_count: int) -> void:
	_update_text(new_count)


func _update_text(count: int) -> void:
	collectible_label.text = "x" + str(count)
