extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const ACCELERATION = 1800.0
const FRICTION = 1600.0       
const AIR_RESISTANCE = 800.0  

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Variable jump height: cut jump short if the jump button is released early
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= 0.5

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		var current_friction = FRICTION if is_on_floor() else AIR_RESISTANCE
		velocity.x = move_toward(velocity.x, 0.0, current_friction * delta)

	move_and_slide()
