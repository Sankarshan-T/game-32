class_name Collectible2D
extends Area2D

@export var value: int = 1
@export var item_id: String = ""

func _ready() -> void:
	item_id = str(get_path())

	if GameState.has_flag(item_id):
		queue_free()
		return

	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		GameState.add_collectibles(value)
		GameState.set_flag(item_id, true)
		queue_free()
