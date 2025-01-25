extends Marker3D

@export var spawn_parent :Node3D

@export var max_miner = 1
@export var max_floating = 3
@export var max_ground = 30

#@export_range(0,1, 0.05) var miner_chance :float = 0.05
#@export_range(0,1, 0.1) var floating_chance :float = 0.1

@export_range(0,1, 0.05) var miner_chance :float = 0.1
@export_range(0,1, 0.1) var floating_chance :float = 0.2

const FLOATING_BUBBLE :PackedScene = preload("res://objects/bubbles/floating_bubble/floating_bubble.tscn")
const GROUND_BUBBLE :PackedScene = preload("res://objects/bubbles/ground_bubble/ground_bubble.tscn")
const MINING_BUBBLE = preload("res://objects/bubbles/mining_bubble/mining_bubble.tscn")

func spawn():
	var instance :Node3D = null
	var rng :float = randf()
	
	var miner_count = Tools.count_nodes_in_group($SpawnedBubbles, "MinerBubble")
	print("Miner count: ", miner_count)
	var floating_count = Tools.count_nodes_in_group($SpawnedBubbles, "FloatingBubble")
	print("Floating count: ", floating_count)
	var ground_count = Tools.count_nodes_in_group($SpawnedBubbles, "GroundBubble")
	print("Ground count: ", ground_count)
	
	if rng < miner_chance and miner_count < max_miner:
		instance = MINING_BUBBLE.instantiate()
	elif rng < floating_chance and floating_count < max_floating:
		instance = FLOATING_BUBBLE.instantiate()
	elif ground_count < max_ground:
		instance = GROUND_BUBBLE.instantiate()
	
	# Only spawns if instance was filled
	if instance != null:
		instance.global_position = get_spawn_pos()
		spawn_parent.add_child(instance)

func get_spawn_pos() -> Vector3:
	var pos :Vector3 = global_position
	
	var radius = ($Area3D/CollisionShape3D.shape as SphereShape3D).radius
	
	var target :Vector3 = Vector3(
		randf_range(pos.x - radius, pos.x + radius),
		global_position.y,
		randf_range(pos.z - radius, pos.z + radius)
	)
	
	if target.length() > radius - 1:
		target = target.normalized() * (radius-1)
	
	return target

func _on_spawn_timer_timeout():
	spawn()
	$SpawnTimer.start()
