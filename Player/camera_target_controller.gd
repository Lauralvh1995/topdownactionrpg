extends Node3D

@export var camera_raycast : RayCast3D
@export var camera_target : Node3D
@export var camera_offset : float = 0.01


func _process(delta: float) -> void:
	if camera_raycast.is_colliding():
		camera_target.global_position.y = camera_raycast.get_collision_point().y + camera_offset
		
	else:
		camera_target.global_position.y = global_position.y + camera_raycast.target_position.y + camera_offset
		print("Where did the floor go?")
