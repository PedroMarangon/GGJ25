extends Control

func _ready() -> void:
	visible = false
	
func activate():
	visible = true
	for i in BubblePoints.get_ranked_points():
		$Leaderboard/Label.text += "Player: %d \n" % [i]
