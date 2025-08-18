extends Node3D

@export var follow_target : Node3D
@export var height_offset : float = 0.75
@export var drag : float = 2.0

func _process(delta: float) -> void:
	global_position.x = lerp(global_position.x, follow_target.global_position.x, drag * delta)
	global_position.z = lerp(global_position.z, follow_target.global_position.z, drag * delta)
	global_position.y = lerp(global_position.y, follow_target.global_position.y + height_offset, drag * delta)
	
