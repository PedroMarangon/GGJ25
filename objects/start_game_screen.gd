extends Control

signal pressedEnter
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_joy_button_pressed(0, JOY_BUTTON_A) or Input.is_joy_button_pressed(1, JOY_BUTTON_A) or Input.is_joy_button_pressed(2, JOY_BUTTON_A) or Input.is_joy_button_pressed(3, JOY_BUTTON_A):
		pressedEnter.emit()
	if Input.is_key_pressed(KEY_Q):
		Tools.skip_logo = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Tools.skip_logo:
		self.modulate = Color(1, 1, 1, 1)
		get_tree().paused = true
		await pressedEnter
		get_tree().paused = false
		self.queue_free()
		Tools.skip_logo = true
	else:
		visible = true
		self.queue_free()
