extends Area3D

func _on_body_entered(body :Node3D):
	if body is not Player:
		return
	
	var player_id :int = (body as Player).id
	
	BubblePoints.add_bubble_points(player_id, BubblePointSystem.BubbleValues.GROUND)
	
	self.queue_free()
