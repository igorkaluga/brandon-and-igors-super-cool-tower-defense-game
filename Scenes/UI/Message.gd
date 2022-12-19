extends TextureRect

onready var timer = $Timer
onready var label = $Label

var message_time = 3.0

func update_message(message, time = message_time):
	label.text = String(message)
	timer.wait_time = message_time
	timer.start()
	
func _on_MessageBox_gui_input(event):
	if event is InputEventMouseButton:
		queue_free()
		
func _on_Timer_timeout():
	queue_free()
