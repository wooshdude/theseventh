extends KinematicBody2D

onready var anim = $AnimationPlayer
onready var sprite = $Sprite
onready var hatWire = $hatWire
onready var headWire = $headWire
onready var bodyWire = $bodyWire
onready var attackSprite = $attack2
onready var playerAttack = $attack
onready var jumpSprite = $jump
onready var footsteps = $footsteps
onready var landing = $landing
onready var swing = $swing

export (int) var speed = 50
export (int) var jump_speed = -100
export (int) var gravity = 500
export (int) var airAttack = 1
export (float, 0, 1.0) var friction = 0.5
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
var state = MOVE
var canAttack = true
var hasLanded = false
var hasSwung = false

#global and local mouse positions
var mpos = get_global_mouse_position()
var lMpos = get_local_mouse_position()

#possible states
enum {
	MOVE,
	IDLE,
	ATTACK
}

func _process(delta):
	
	#players possible states
	match state:
		MOVE:
			get_input()
			movement(delta)
		IDLE:
			movement(delta)
		ATTACK:
			attack()
			velocity = Vector2.ZERO
			movement(delta)
	
	#gets users mouse position
	mpos = get_global_mouse_position()
	lMpos = get_local_mouse_position()
	
	#determines if the player is jumping or falling and changes sprite
	if is_on_floor() == false and velocity.y < 0:
		jumpSprite.visible = true
		anim.play("jump")
		jumpSprite.frame = 0
	elif is_on_floor() == false and velocity.y > 0:
		jumpSprite.visible = true
		anim.play("jump")
		jumpSprite.frame = 1
		hasLanded = false
	else:
		jumpSprite.visible = false
		if hasLanded == false:
			landing.play(0)
			hasLanded = true
			footsteps.playing = true


#handles all user inputs
func get_input():
	var dir = 0
	
	#gets character direction
	if Input.is_action_pressed("ui_right"):
		dir += 1
		sprite.flip_h = false
		playerAttack.flip_h = false
		jumpSprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		dir -= 1
		sprite.flip_h = true
		playerAttack.flip_h = true
		jumpSprite.flip_h = true
		
	#handles acceleration
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		anim.play("walking")
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		anim.play("idle")
		footsteps.stop()
	
	#attacks
	if Input.is_action_pressed("leftMouse"):
		if is_on_floor():
			state = ATTACK
		attackSprite.look_at(mpos)
		
		if lMpos.x > 0:
			sprite.flip_h = false
			playerAttack.flip_h = false
			jumpSprite.flip_h = false
			attackSprite.flip_v = false
		else:
			sprite.flip_h = true
			playerAttack.flip_h = true
			jumpSprite.flip_h = true
			attackSprite.flip_v = true
		
		$Timer.start()

#handles players physics
func movement(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		airAttack = 1
	if Input.is_action_pressed("ui_select"):
		if is_on_floor():
			velocity.y = jump_speed
	audio()

#handles attacking
func attack():
	anim.play("basicAttack")
	
	if $Timer.time_left == 0:
		anim.play("idle")
		state = MOVE

func audio():
	if is_on_floor() == false:
		footsteps.playing = false

func _on_landing_finished():
	hasLanded = true
