extends Control

var referenceVboxPositions = null
var referenceLabels : Array = []
func _ready():	
	referenceLabels.append($"Panel/VBoxContainer/VBoxContainer2/Player1")
	referenceLabels.append($"Panel/VBoxContainer/VBoxContainer2/Player2")
	referenceLabels.append($"Panel/VBoxContainer/VBoxContainer2/Player3")
	referenceLabels.append($"Panel/VBoxContainer/VBoxContainer2/Player4")

func _process(delta: float) -> void:
	if referenceVboxPositions == null:
		referenceVboxPositions = []
		referenceVboxPositions.append($"Panel/VBoxContainer/referenceVbox/pos1".position)
		referenceVboxPositions.append($"Panel/VBoxContainer/referenceVbox/pos2".position)
		referenceVboxPositions.append($"Panel/VBoxContainer/referenceVbox/pos3".position)
		referenceVboxPositions.append($"Panel/VBoxContainer/referenceVbox/pos4".position)
		$"Panel/VBoxContainer/referenceVbox".visible = false
	
	_update_leaderboard(delta)
	
func _update_leaderboard(delta):
	var bubble_rank = BubblePoints.get_ranked_points()
	for player_rank in bubble_rank:
		var player_info = bubble_rank[player_rank]
		var player_id = player_info[0]
		var player_score = player_info[1]
		
		referenceLabels[player_id].position = referenceLabels[player_id].position.lerp(referenceVboxPositions[player_rank], delta*3)
		# If it's a promotion!
		if referenceLabels[player_id].position.distance_to(referenceVboxPositions[player_rank]) > 1 and referenceLabels[player_id].position.y > referenceVboxPositions[player_rank].y:
			referenceLabels[player_id].label_settings.shadow_size = lerp(referenceLabels[player_id].label_settings.shadow_size, 30, 0.2)
		else:
			referenceLabels[player_id].label_settings.shadow_size = lerp(referenceLabels[player_id].label_settings.shadow_size, 0, 0.2)
		referenceLabels[player_id].text = "Player %d: %d" % [player_id + 1, player_score]
