extends Node2D

onready var player = $"../player"

var mpos = get_global_mouse_position()
var view

enum {
	COOL,
	LAME
}

var state = LAME

func _process(delta):
	match state:
		COOL:
			coolCam()
		LAME:
			lameCam()

func lameCam():
	self.global_position = get_parent().global_position

func coolCam():
	self.position.x =  lerp(player.position.x, mpos.x, 1) / 3
	self.position.y =  lerp(player.position.y, mpos.y, 1) / 3
	mpos = get_local_mouse_position()
#
#	self.global_position = self.global_position - (get_global_mouse_position() - player.position) /2


	
	
	
	
	
	
	
	
	
	
	
	
