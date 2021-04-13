extends KinematicBody2D

onready var anim = $AnimationPlayer
onready var sprite = $Sprite
onready var hatWire = $hatWire
onready var headWire = $headWire
onready var bodyWire = $bodyWire

export (int) var speed = 50
export (int) var jump_speed = -100
export (int) var gravity = 500
export (float, 0, 1.0) var friction = 0.5
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
var state = MOVE

enum {
	MOVE,
	IDLE
}


func _process(delta):
	match state:
		MOVE:
			get_input()
			movement(delta)
		IDLE:
			movement(delta)

func get_input():
	var dir = 0
	if Input.is_action_pressed("ui_right"):
		dir += 1
		sprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		dir -= 1
		sprite.flip_h = true
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		anim.play("walking")
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		anim.play("idle")

func movement(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("ui_select"):
		if is_on_floor():
			velocity.y = jump_speed
