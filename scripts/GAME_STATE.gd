extends Node

signal health_changed(new_health: int, max_health: int)
signal collectible_count_changed(new_count: int)
signal player_died

@export var max_health: int = 100
var current_health: int = 100
var collectibles: int = 0

var flags: Dictionary = {}


func _ready() -> void:
	current_health = max_health


func take_damage(amount: int) -> void:
	current_health = clampi(current_health - amount, 0, max_health)
	health_changed.emit(current_health, max_health)
	
	if current_health <= 0:
		player_died.emit()


func heal(amount: int) -> void:
	current_health = clampi(current_health + amount, 0, max_health)
	health_changed.emit(current_health, max_health)


func add_collectibles(amount: int = 1) -> void:
	collectibles += amount
	collectible_count_changed.emit(collectibles)


func set_flag(flag_name: String, value: bool = true) -> void:
	flags[flag_name] = value


func has_flag(flag_name: String) -> bool:
	return flags.get(flag_name, false)


func reset_state() -> void:
	current_health = max_health
	collectibles = 0
	flags.clear()
	health_changed.emit(current_health, max_health)
	collectible_count_changed.emit(collectibles)
