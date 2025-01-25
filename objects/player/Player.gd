extends Node3D
class_name Player

@export var material : Material
@export var id :int = 0
@export var can_jump :bool = true

@export var rolling_force = 7
@export var jumping_force = 1.5

@onready var rigid_body_3d :RigidBody3D = $RigidBody3D

func _ready():
	%HamsterMesh.set_surface_override_material(0, material)

func _physics_process(delta):
	$FloorCheck.global_transform.origin = $RigidBody3D.global_transform.origin
	$Score.global_transform.origin = $RigidBody3D.global_transform.origin + Vector3(0, 2.3, -1)
	
	$RigidBody3D.linear_velocity.x -= Input.get_joy_axis(id, JOY_AXIS_LEFT_X)*(rolling_force*delta)
	$RigidBody3D.linear_velocity.z -= Input.get_joy_axis(id, JOY_AXIS_LEFT_Y)*(rolling_force*delta)
	
	if can_jump and Input.is_joy_button_pressed(id, JOY_BUTTON_A) and $FloorCheck.is_colliding():
		$RigidBody3D.apply_central_impulse(Vector3(0, 1, 0) * jumping_force)
	
	$HamsterParent.global_transform.origin = $RigidBody3D.global_transform.origin + (Vector3.DOWN * 0.25)
	
	
	var target_rotation = atan2(-Input.get_joy_axis(id, JOY_AXIS_LEFT_X), -Input.get_joy_axis(id, JOY_AXIS_LEFT_Y))  # Get angle in radians
	var target_degrees = rad_to_deg(target_rotation)  # Convert to degrees
	$HamsterParent.rotation_degrees = Vector3(0,target_degrees,0)
	
	update_player_score()
	
func update_player_score():
	var number = BubblePoints.get_points_by_id(id)
	var padded = "%03d" % number
	$Score.text = "P" + str(id + 1) + " " + "BP: " + str(padded)
