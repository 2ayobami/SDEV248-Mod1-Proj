extends CharacterBody2D

const SPEED         := 120.0
const JUMP_VELOCITY := -350.0
const GRAVITY       := 900.0
const MAX_FALL      := 600.0

var _alive := true

@onready var sprite : Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if not _alive:
		# apply physics so death arc plays out
		if not is_on_floor():
			velocity.y = min(velocity.y + GRAVITY * delta, MAX_FALL)
		move_and_slide()
		return

	# Gravity
	if not is_on_floor():
		velocity.y = min(velocity.y + GRAVITY * delta, MAX_FALL)

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal
	var dir := Input.get_axis("move_left", "move_right")
	if dir != 0.0:
		velocity.x = dir * SPEED
		sprite.flip_h = dir < 0.0
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED * 8 * delta)

	move_and_slide()

	# Fell into pit
	if position.y > 400:
		die()

# Called by stomp: bounce off enemy top
func stomp_enemy() -> void:
	velocity.y = JUMP_VELOCITY * 0.6

# Public: called by enemy body contact OR pit fall
func die() -> void:
	if not _alive:
		return
	_alive = false
	velocity = Vector2(0, -280)   # pop upward for death arc
	await get_tree().create_timer(1.2).timeout
	get_tree().reload_current_scene()
