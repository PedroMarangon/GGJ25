extends Node3D

@export var health = 3

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("PLAYER"):
		return
	
	var collided_player = body.get_parent() as Player
	
	var player_id :int = collided_player.id
	
	health -= 1
	body.linear_velocity.y = 5
	body.linear_velocity.x = randf_range(-8, 8)
	body.linear_velocity.z = randf_range(-8, 8)
	if health <= 0:
		BubblePoints.add_bubble_points(player_id, BubblePointSystem.BubbleValues.MINER)
		self.queue_free()
