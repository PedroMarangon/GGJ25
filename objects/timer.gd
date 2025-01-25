extends Label

signal round_over

@export var remaining_time_seconds = 301

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label_update()
	$Timer.connect("timeout", label_update)

func label_update():
	remaining_time_seconds -= 1
	var minutes = remaining_time_seconds / 60
	var secs = remaining_time_seconds % 60
	text = "%02d:%02d" % [minutes, secs]
	
	if remaining_time_seconds <= 0:
		round_over.emit()
