extends Control

var dialog = [
	'test1eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee', 
	'big [wave][rainbow]testing[/rainbow] gamer time eeeeeeeeeeeeeeee [tornado amp = 100]PP[/tornado][/wave] gamer time. XDDDDD wowowe', 
	'test3eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
	'eeeeee'
]

var dialog_index = 0
var finished = false
var text_speed = 20
var text_time

func _ready():
	load_dialog()
	

func _process(delta):
	#$"next_indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()


func load_dialog():
	if dialog_index < dialog.size():
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		text_time = str($RichTextLabel.get_text()).length() / text_speed
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property($RichTextLabel, "percent_visible", 0, 1, text_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		queue_free()
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = false
