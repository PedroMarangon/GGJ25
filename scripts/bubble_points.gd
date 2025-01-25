extends Node
class_name BubblePointSystem


enum BubbleValues
{
	GROUND,
	FLOATING,
	MINER
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

func get_ranked_points() -> Array[int]:
	var result :Array[int] = [player1_bubbles, player2_bubbles, player3_bubbles, player4_bubbles]
	
	result.sort()
	result.reverse()
	
	return result


func update_ui():
	p1_label.text = "Player 1 Bubbles: %s" % player1_bubbles
	p2_label.text = "Player 2 Bubbles: %s" % player2_bubbles
	p3_label.text = "Player 3 Bubbles: %s" % player3_bubbles
	p4_label.text = "Player 4 Bubbles: %s" % player4_bubbles


func _sort_descending(a, b):
	return b - a
