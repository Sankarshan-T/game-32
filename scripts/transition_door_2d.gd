class_name TransitionDoor2D
extends Area2D

@export_file("*.tscn") var target_scene: String = ""

var triggered: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if triggered or target_scene == "":
		return

	if body is CharacterBody2D:
		triggered = true
		body.set_physics_process(false)
		SceneManager.change_scene(target_scene)
