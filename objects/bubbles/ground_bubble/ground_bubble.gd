extends Area3D

func _on_body_entered(body :Node3D):
	if not body.is_in_group("PLAYER"):
		return
	
	var collided_player = body.get_parent() as Player
	
	var player_id :int = collided_player.id
	
	BubblePoints.add_bubble_points(player_id, BubblePointSystem.BubbleValues.GROUND)
	AudioManager.play(["res://sounds/pops/pop001.ogg","res://sounds/pops/pop002.ogg","res://sounds/pops/pop003.ogg"], 1, -50)
	
	self.queue_free()
