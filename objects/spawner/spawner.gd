extends Marker3D


@export var spawn_parent :Node3D

@export_range(0,1, 0.05) var miner_chance :float = 0.05
@export_range(0,1, 0.1) var floating_chance :float = 0.1

const FLOATING_BUBBLE :PackedScene = preload("res://objects/bubbles/floating_bubble/floating_bubble.tscn")
const GROUND_BUBBLE :PackedScene = preload("res://objects/bubbles/ground_bubble/ground_bubble.tscn")
const MINING_BUBBLE = preload("res://objects/bubbles/mining_bubble/mining_bubble.tscn")


func spawn():
	var instance :Node3D = null
	var rng :float = randf()
	
	if rng < miner_chance:
		instance = MINING_BUBBLE.instantiate()
	elif rng < floating_chance:
		instance = FLOATING_BUBBLE.instantiate()
	else:
		instance = GROUND_BUBBLE.instantiate()
	
	
	
	
	instance.global_position = get_spawn_pos()
	
	spawn_parent.add_child(instance)
	
	pass

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
