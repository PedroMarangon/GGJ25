extends Node3D

@export var health = 3

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body.is_in_group("PLAYER"):
		return
	
	var collided_player = body.get_parent() as Player
	
	var player_id :int = collided_player.id
	
	
	
	
	var land_tween = get_tree().create_tween()
	const LAND_SCALE = Vector3(1.194, 0.893, 1.194)
	
	land_tween.tween_property($miner_bubble, "scale", LAND_SCALE, 0.1)
	land_tween.tween_property($miner_bubble, "scale", Vector3.ONE, 0.1)
	
	
	
	
	
	
	health -= 1
	AudioManager.play(["res://sounds/miner_jump.ogg"], 0.5, 0)
	body.linear_velocity.y = 24
	body.linear_velocity.x = randf_range(-8, 8)
	body.linear_velocity.z = randf_range(-8, 8)
	if health <= 0:
		BubblePoints.add_bubble_points(player_id, BubblePointSystem.BubbleValues.MINER)
		
		$StaticBody3D.queue_free()
		$Area3D.queue_free()
		
		var death_tween = get_tree().create_tween()
		const DEATH_SCALE = Vector3(1.5, 0, 1.5)
		
		death_tween.tween_property($miner_bubble, "scale", DEATH_SCALE, 0.2)
		death_tween.tween_callback(queue_free)
		AudioManager.play(["res://sounds/pops/pop006_miner.ogg"], 0.5, -30)
		
		#self.queue_free()
