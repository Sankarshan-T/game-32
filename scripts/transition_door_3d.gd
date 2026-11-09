class_name TransitionDoor3D
extends Area3D

@export_file("*.tscn") var target_scene: String = ""

var triggered: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if triggered or target_scene == "":
		return

	if body is CharacterBody3D:
		triggered = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		body.set_physics_process(false)
		SceneManager.change_scene(target_scene)
