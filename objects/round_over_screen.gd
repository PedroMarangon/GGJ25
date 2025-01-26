extends Control

@export var player_colors : Array[Color]

func _ready() -> void:
	visible = false
	
func activate():
	var player_id = BubblePoints.get_ranked_points()[0][0]
	visible = true	
	$FimDeRodada3.modulate = Color(1, 1, 1, 0)
	$FimDeRodada2.text = "Player %s venceu!" % [player_id + 1]
	$FimDeRodada2.modulate = player_colors[player_id]
	
func activate_x_to_continue():
	var tween : Tween = self.create_tween()
	await tween.tween_property($FimDeRodada3, "modulate", Color.WHITE, 0.3)
