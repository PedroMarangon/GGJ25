extends Node3D
class_name Player

@export var id :int = 0

@export var rolling_force = 7
@export var jumping_force = 1.5

@onready var rigid_body_3d = $RigidBody3D

func _physics_process(delta):
	print("Player ", id, "height: ", $RigidBody3D.global_position.y)
	
	$FloorCheck.global_transform.origin = $RigidBody3D.global_transform.origin
	
	$RigidBody3D.linear_velocity.x -= Input.get_joy_axis(id, JOY_AXIS_LEFT_X)*(rolling_force*delta)
	$RigidBody3D.linear_velocity.z -= Input.get_joy_axis(id, JOY_AXIS_LEFT_Y)*(rolling_force*delta)
	
	if Input.is_joy_button_pressed(id, JOY_BUTTON_A) and $FloorCheck.is_colliding():
		$RigidBody3D.apply_central_impulse(Vector3(0, 1, 0) * jumping_force)
