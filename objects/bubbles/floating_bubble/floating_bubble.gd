extends Area3D

@export var current_player :Player


func _physics_process(delta):
	if current_player == null:
		return
	$CollisionShape3D.global_position = current_player.rigid_body_3d.global_position

func _on_body_entered(body :Node3D):
	if not body.is_in_group("PLAYER"):
		return
	
	var collided_player = body.get_parent() as Player
	
	if current_player == null and current_player != collided_player:
		current_player = collided_player
		current_player.can_jump = false
		
		var rb = current_player.rigid_body_3d
		rb.gravity_scale = 0
		rb.linear_velocity = Vector3(rb.linear_velocity.x, 0, rb.linear_velocity.z)
		
		$PointsTimer.start()
		$BubbleTimer.start()
		return
	
	_on_bubble_timer_timeout()


func _on_bubble_timer_timeout():
	$PointsTimer.stop()
	$BubbleTimer.stop()
	if current_player != null:
		current_player.can_jump = true
		current_player.rigid_body_3d.gravity_scale = 1
		current_player = null
	self.queue_free()


func _on_points_timer_timeout():
	BubblePoints.add_bubble_points(current_player.id, BubblePointSystem.BubbleValues.FLOATING)
	$PointsTimer.start()
