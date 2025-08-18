extends Node3D

@export var shadow_raycast : RayCast3D
@export var shadow_anchor : Node3D
@export var shadow_offset = 0.01

func _process(delta: float) -> void:
	if shadow_raycast.is_colliding():
		shadow_anchor.global_position.y = shadow_raycast.get_collision_point().y + shadow_offset
		
	else:
		shadow_anchor.global_position.y = global_position.y + shadow_raycast.target_position.y + shadow_offset
		print("Where did the floor go?")
