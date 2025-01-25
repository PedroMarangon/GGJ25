extends Node
class_name GameManager

func _ready() -> void:
	%Timer.round_over.connect(round_over)

var round_over_button_trigger = false
const leaderboard_time = 10
func round_over():
	get_tree().paused = true
	%PlayerPoints.visible = false
	%Timer.visible = false
	%RoundOverScreen.activate()
	round_over_button_trigger = true
	await get_tree().create_timer(10).timeout
	get_tree().paused = false
	get_tree().reload_current_scene()
	BubblePoints.reset_score()
