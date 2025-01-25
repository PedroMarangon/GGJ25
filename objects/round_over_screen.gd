extends Control

func _ready() -> void:
	visible = false
	
func activate():
	visible = true
	var leaderboard = BubblePoints.get_ranked_points()
	for value in leaderboard:
		var player_points = leaderboard[value]
		$Leaderboard/Label.text += "Player %d: %d \n" % [player_points[0] + 1, player_points[1]]
