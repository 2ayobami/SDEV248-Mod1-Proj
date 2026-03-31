extends CharacterBody2D

const SPEED   := 50.0
const GRAVITY := 900.0

var _dir  := -1.0
var _dead := false

@onready var sprite      : Sprite2D = $Sprite2D
@onready var stomp_area  : Area2D   = $StompArea
@onready var body_area   : Area2D   = $BodyArea

func _ready() -> void:
	stomp_area.body_entered.connect(_on_stomp_entered)
	body_area.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	if _dead:
		return
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	velocity.x = _dir * SPEED
	move_and_slide()
	if is_on_wall():
		_dir *= -1.0
	sprite.flip_h = _dir > 0.0

func _on_stomp_entered(body: Node) -> void:
	if _dead:
		return
	if body.has_method("stomp_enemy"):
		body.stomp_enemy()
		_get_stomped()

func _on_body_entered(body: Node) -> void:
	if _dead:
		return
	if body.has_method("die"):
		body.die()

func _get_stomped() -> void:
	_dead = true
	velocity = Vector2.ZERO
	sprite.scale.y = 0.3
	sprite.position.y += 6
	$CollisionShape2D.disabled = true
	stomp_area.monitoring = false
	body_area.monitoring = false
	await get_tree().create_timer(0.4).timeout
	queue_free()
