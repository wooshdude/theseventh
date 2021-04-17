extends KinematicBody2D

#onready vars
onready var anim = $AnimationPlayer
onready var sprite = $Sprite
onready var particles = $Particles2D

#enumerators
#all possible character states
enum {
	IDLE,
	MOVE,
	CUTSCENE
}

#variables
var velocity = Vector2.ZERO
var speed = 60 #character speed
var state = IDLE #characters current state
func ready():
	pass
	
func _process(delta):
	#switch characters states
	match state:
		IDLE:
			idle()
		MOVE:
			move()
		CUTSCENE:
			cutscene()
	
func idle():
	anim.play("idle")
	particles.emitting = false
	
	#detect if the player is pressing input keys
	if Input.get_action_strength("ui_right") or Input.get_action_strength("ui_left") or Input.get_action_strength("ui_down") or Input.get_action_strength("ui_up"):
		state = MOVE

func move():
	velocity = Vector2.ZERO
	
	#checks if keys are being pressed and adds them to the velocity
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#does movement shit
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
	
	#animates character
	if velocity:
		anim.play("walking")
		particles.emitting = true
	else:
		state = IDLE
		particles.emitting = false
	
	#flips character sprite
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true

#	if get_global_mouse_position().x >= position.x:
#		sprite.flip_h = false
#	else:
#		sprite.flip_h = true

func cutscene():
	pass












