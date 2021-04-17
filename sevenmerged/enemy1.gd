extends KinematicBody2D

var health = 3
var velocity = Vector2.ZERO
export var gravity = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	print($Timer.time_left)

func die():
	$Particles2D.emitting = true
	$Sprite.visible = false
	get_node("Area2D/CollisionShape2D").disabled = true
	$Area2D.monitoring = false
	get_node("CollisionShape2D").disabled= true
	$Timer.start()
	queue_free()
	

func movement(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_area_entered(area):
	health -= 1
	$damage.play(0)
	if health == 0:
		die()
