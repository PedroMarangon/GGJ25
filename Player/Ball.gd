extends RigidBody3D

var rolling_force = 50
var jumping_force = 10

func _physics_process(delta):
	$CameraRig.global_transform.origin = lerp(
		$CameraRig.global_transform.origin, 
		global_transform.origin, 0.1
	)
	$FloorCheck.global_transform.origin = global_transform.origin
	if Input.is_action_pressed("ui_down"):
		angular_velocity.x -= rolling_force*delta
	elif Input.is_action_pressed("ui_up"):
		angular_velocity.x += rolling_force*delta
	if Input.is_action_pressed("ui_right"):
		angular_velocity.z += rolling_force*delta
	elif Input.is_action_pressed("ui_left"):
		angular_velocity.z -= rolling_force*delta

	if Input.is_action_just_pressed("ui_accept") and $FloorCheck.is_colliding():
		print("Jump")
		apply_impulse(Vector3(0, 1, 0) * jumping_force)
