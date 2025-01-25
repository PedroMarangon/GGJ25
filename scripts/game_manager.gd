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

func _on_death_area_body_entered(body: Node3D) -> void:
	if not body.is_in_group("PLAYER"):
		return
	
	await get_tree().create_timer(3).timeout
	BubblePoints.remove_bubble_points(BubblePoints.BubblePenalties.DEATH, body.get_parent().id)
	body.linear_velocity = Vector3.ZERO
	body.position = Vector3.ZERO
