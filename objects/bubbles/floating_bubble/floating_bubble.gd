extends Area3D

@export var current_player :Player

var sin_counter :float = 0

func _ready():
	sin_counter = randf_range(-10, 10)

func _physics_process(delta):
	if current_player == null:
		sin_counter += delta
		$CollisionShape3D/MainMesh.position.y = sin(sin_counter) * 0.5
		return
	
	$CollisionShape3D.global_position = current_player.rigid_body_3d.global_position
	
	
	

func _on_body_entered(body :Node3D):
	if not body.is_in_group("PLAYER"):
		return
	
	var collided_player = body.get_parent() as Player
	
	if not collided_player.can_jump:
		return
	
	if current_player == null and current_player != collided_player:
		current_player = collided_player
		current_player.can_jump = false
		
		var rb = current_player.rigid_body_3d
		rb.gravity_scale = 0
		rb.linear_velocity = Vector3(rb.linear_velocity.x, 0, rb.linear_velocity.z)
		
		$ShadowMesh.queue_free()
		
		
		var land_tween = get_tree().create_tween()
		const LAND_SCALE = Vector3(1.405, 0.955, 1.405)
		const FINAL_SCALE = Vector3(1.7, 0.5, 1.7)
		
		AudioManager.play(["res://sounds/floating_bubble.ogg"], 1.05, 0)
		land_tween.tween_property($CollisionShape3D/MainMesh, "scale", LAND_SCALE, 0.1)
		land_tween.tween_property($CollisionShape3D/MainMesh, "scale", Vector3.ONE, 0.1)
		land_tween.tween_property($CollisionShape3D/MainMesh, "scale", FINAL_SCALE, $BubbleTimer.wait_time)
		
		$PointsTimer.start()
		$BubbleTimer.start()
		return
	
	_on_bubble_timer_timeout()


func _on_bubble_timer_timeout():
	$PointsTimer.stop()
	$BubbleTimer.stop()
	if current_player != null:
		current_player.can_jump = true
		current_player.rigid_body_3d.gravity_scale = 8
		current_player = null
	AudioManager.play(["res://sounds/pops/pop004.ogg"], 1, 0)
	self.queue_free()


func _on_points_timer_timeout():
	BubblePoints.add_bubble_points(current_player.id, BubblePointSystem.BubbleValues.FLOATING)
	$PointsTimer.start()
