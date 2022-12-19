extends PathFollow2D

export var speed := 50
export var damage := 0
signal enemy_death
signal path_complete
var timer

var text = preload("res://Scenes/Functional/FloatingText.tscn")
var music_notes = ["q", "n"]
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.set_wait_time(0.5)
	timer.set_one_shot(false)
	timer.start()
	
	$Information.connect("input_event", self, "_on_Information_input_event", [self])
	
func _on_timer_timeout():
	var speech = text.instance()
	var musical_note = randi() % music_notes.size()
	speech.text = music_notes[musical_note]

	add_child(speech)
	
func _on_Information_input_event( viewport, event, shape_idx, tower ):
	if event.is_action_pressed("ui_accept") and event.pressed:
		var speech = text.instance()
		speech.text = "q n"
		add_child(speech)
		
func _physics_process(delta):
	if unit_offset >= 1.0:
		emit_signal("path_complete", damage)
		queue_free()
	set_offset(get_offset() + speed * delta)

