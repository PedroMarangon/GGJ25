extends Node
class_name BubblePointSystem


enum BubbleValues
{
	GROUND,
	FLOATING,
	MINER
}

enum BubblePenalties
{
	DEATH
}

var p1_label :Label
var p2_label :Label
var p3_label :Label
var p4_label :Label

@export var ground_bubble_value :int = 1
@export var floating_bubble_value :int = 5
@export var miner_bubble_value :int = 100

@export var player1_bubbles :int = 0
@export var player2_bubbles :int = 0
@export var player3_bubbles :int = 0
@export var player4_bubbles :int = 0

func add_bubble_points(player:int, bubble_type:BubbleValues) -> void:
	var value_to_add :int = 0
	match bubble_type:
		BubbleValues.GROUND: value_to_add = ground_bubble_value
		BubbleValues.FLOATING: value_to_add = floating_bubble_value
		BubbleValues.MINER: value_to_add = miner_bubble_value
	
	match player:
		0: player1_bubbles += value_to_add
		1: player2_bubbles += value_to_add
		2: player3_bubbles += value_to_add
		3: player4_bubbles += value_to_add

	update_ui()

func get_ranked_points() -> Dictionary:
	var scores = {
		0: player1_bubbles,
		1: player2_bubbles,
		2: player3_bubbles,
		3: player4_bubbles
	}
	
	# Ordena os jogadores por pontuação (do maior para o menor)
	var ranked = scores.keys()
	ranked.sort_custom(func(a, b): return scores[b] < scores[a])
	var ranking = {}
	for i in range(ranked.size()):
		ranking[i] = [ranked[i], scores[ranked[i]]]
	return ranking

func update_ui():
	p1_label.text = "Player 1 Bubbles: %s" % player1_bubbles
	p2_label.text = "Player 2 Bubbles: %s" % player2_bubbles
	p3_label.text = "Player 3 Bubbles: %s" % player3_bubbles
	p4_label.text = "Player 4 Bubbles: %s" % player4_bubbles
	
func reset_score():
	player1_bubbles = 0
	player2_bubbles = 0
	player3_bubbles = 0
	player4_bubbles = 0
	
func remove_bubble_points(bubble_penalty, player_id):
	var penalty = 0
	match bubble_penalty:
		BubblePenalties.DEATH:
			penalty = 50
			
	match player_id:
		0: player1_bubbles -= penalty
		1: player2_bubbles -= penalty
		2: player3_bubbles -= penalty
		3: player4_bubbles -= penalty
		
	player1_bubbles = clamp(player1_bubbles, 0, 99999999)
	player2_bubbles = clamp(player2_bubbles, 0, 99999999)
	player3_bubbles = clamp(player3_bubbles, 0, 99999999)
	player4_bubbles = clamp(player4_bubbles, 0, 99999999)
