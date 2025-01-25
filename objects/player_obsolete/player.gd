# OBSOLETO

extends CharacterBody3D
#class_name Player

@export var id :int = 0

@export var speed: float = 10
@export var gravity: float = 9.8
@export var rotation_speed: float = 2.0
@export var jump_force: float = 10.0
@export var acceleration: float = 3.0
@export var friction: float = 1.0

@onready var camera: Camera3D = get_parent().get_node("Camera3D")

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle jumping
	if is_on_floor() and Input.is_joy_button_pressed(id, JOY_BUTTON_A):
		velocity.y = jump_force
	
	# Get input direction
	var input_dir := Vector2.ZERO
	
	input_dir.x = Input.get_joy_axis(id, JOY_AXIS_LEFT_X)
	input_dir.y = -Input.get_joy_axis(id, JOY_AXIS_LEFT_Y)
	
	# Transform input direction based on camera orientation
	var cam_basis = camera.global_transform.basis
	var forward = -cam_basis.z.normalized()
	var right = cam_basis.x.normalized()
	var direction = (right * input_dir.x + forward * input_dir.y).normalized()
	
	# Apply acceleration and friction
	if input_dir != Vector2.ZERO:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
		velocity.z = move_toward(velocity.z, direction.z * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		velocity.z = move_toward(velocity.z, 0, friction * delta)
	
	# Move the character
	move_and_slide()
	
	# Rotate the sphere based on movement
	var rotation_axis = Vector3(velocity.z, 0, -velocity.x).normalized()
	var rotation_amount = velocity.length() * rotation_speed * delta
	if rotation_axis.length() > 0:
		$MeshInstance3D.rotate(rotation_axis, rotation_amount)
