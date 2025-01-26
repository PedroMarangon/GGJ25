extends Node3D
class_name Player

@export var material : Material
@export var id :int = 0
@export var can_jump :bool = true

@export var rolling_force = 7
@export var jumping_force = 1.5

@onready var rigid_body_3d :RigidBody3D = $RigidBody3D

# Qual foi o último player que bateu neste player atual, se este player atual morrer, os pontos desse aqui vai pra o id dessa variável
var last_player_collided_id = null

func _ready():
	$HamsterParent.scale = Vector3.ONE * 0.5
	%Score.scale = Vector3.ONE * 1.5
	%HamsterMesh.set_surface_override_material(0, material)

func _physics_process(delta):
	$FloorCheck.global_transform.origin = $RigidBody3D.global_transform.origin
	var joystick_input = Vector2(Input.get_joy_axis(id, JOY_AXIS_LEFT_X),Input.get_joy_axis(id, JOY_AXIS_LEFT_Y))
	
	update_position(joystick_input, delta)
	
	$HamsterParent.global_transform.origin = $RigidBody3D.global_transform.origin + (Vector3.DOWN * 0.25)
	
	update_hamster_y_rotation(joystick_input)
	
	update_hamster_running_rot(delta, joystick_input)
	
	update_player_score()


func update_position(joystick :Vector2,delta:float):
	$RigidBody3D.linear_velocity.x -= joystick.x*(rolling_force*delta)
	$RigidBody3D.linear_velocity.z -= joystick.y*(rolling_force*delta)
	if can_jump and Input.is_joy_button_pressed(id, JOY_BUTTON_A) and $FloorCheck.is_colliding():
		$RigidBody3D.apply_central_impulse(Vector3(0, 1, 0) * jumping_force)


func update_hamster_y_rotation(joystick :Vector2):
	var target_rotation = atan2(-joystick.x, -joystick.y)  # Get angle in radians
	var target_degrees = rad_to_deg(target_rotation)  # Convert to degrees
	$HamsterParent.rotation_degrees = Vector3(0,target_degrees,0)


func update_hamster_running_rot(delta:float, input:Vector2):
	const MULTIPLIER = 200
	var run_strength = input.length() * $RigidBody3D.linear_velocity.length()
	var run_angle = 10
	%HamsterMesh.rotation_degrees = Vector3.RIGHT * -sin(delta * run_strength * MULTIPLIER) * run_angle

func update_player_score():
	var number = BubblePoints.get_points_by_id(id)
	var padded = "%03d" % number
	%Score.text = "P" + str(id + 1) + " " + "BP: " + str(padded)

func _on_rigid_body_3d_body_entered(body: Node) -> void:
	if body.get_parent().is_in_group("PLAYER"):
		print("Player %d marked Player %d" % [body.get_parent().id+1, id+1])
		last_player_collided_id = body.get_parent().id

func _on_clear_last_player_collided_timeout() -> void:
	last_player_collided_id = null
	$ClearLastPlayerCollided.start()
