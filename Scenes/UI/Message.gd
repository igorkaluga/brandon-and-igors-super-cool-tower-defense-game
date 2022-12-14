extends TextureRect

func update_message(message):
	var label = $Label
	label.text = String(message)
	
func _on_MessageBox_gui_input(event):
	if event is InputEventMouseButton:
		queue_free()
