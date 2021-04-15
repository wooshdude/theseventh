extends Control

var dialog = preload("res://dialog_box.tscn")


func _on_dialog_box_finished():
	destory()
	respawn()


func destory():
	if self.get_child_count() > 0:
		self.get_child(0).queue_free()


func respawn():
	var dialog_instance = dialog.instance()
	self.add_child(dialog_instance)
	dialog_instance.connect("finished", self, "_on_dialog_box_finished")


