extends "res://enemyControl.gd"

onready var camera = $camera
onready var player = $player
onready var enemy = $enemy1
onready var testNode = $"test node"

func ready():
	pass

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		switchCamTo(testNode)
	else:
		switchCamTo(player)
		

func switchCamTo(object):
	camera.global_position.x = object.global_position.x
	camera.global_position.y = object.global_position.y + -25
