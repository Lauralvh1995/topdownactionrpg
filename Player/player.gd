extends CharacterBody3D
class_name Player

@export var camera : Node3D
@export var fake_shadow_controller : Node3D
@export var state_machine : Node
@export var power_up_controller : PowerUpController

@export_category("Movement Parameters")
@export var ACCELERATION : float = 5.0
@export var ROTATION_SPEED : float = 10.0
@export var MAX_DASHES_IN_AIR : int = 1
@export var DASH_SPEED : float = 10.0
@export var DASH_LENGTH : float = 0.2

@export var JUMP_PEAK_TIME : float = 0.5
@export var JUMP_FALL_TIME : float = 0.5
@export var JUMP_HEIGHT : float = 3.0
@export var JUMP_DISTANCE_AND_MOVEMENT_SPEED : float = 5.0
@export var COYOTE_TIME: float = 0.1

var speed : float = 5.0
var jump_velocity : float = 0.5
var jump_available : bool = true

var camera_forward : Vector3

var jump_gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")
var fall_gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

var input_dir : Vector2
var rotated_dir : Vector3
var facing : Vector3
var dash_counter : int = 0


func _calculate_movement_parameters() -> void:
	jump_gravity = (2*JUMP_HEIGHT)/pow(JUMP_PEAK_TIME, 2)
	fall_gravity = (2*JUMP_HEIGHT)/pow(JUMP_FALL_TIME, 2)
	jump_velocity = jump_gravity * JUMP_PEAK_TIME
	speed = JUMP_DISTANCE_AND_MOVEMENT_SPEED/(JUMP_PEAK_TIME + JUMP_FALL_TIME)

func _ready() -> void:
	_calculate_movement_parameters()
	var temp_forward = camera.global_transform.basis.z
	camera_forward = Vector3(temp_forward.x, 0, temp_forward.z)
	state_machine.initialize()

func _process(delta: float) -> void:
	input_dir = Input.get_vector("left", "right", "forward", "back").normalized()
	rotated_dir = Vector3(input_dir.x, 0, input_dir.y).rotated(
		Vector3.UP, atan2(camera_forward.z,camera_forward.x))
	
	if has_input():
		rotation.y = lerp_angle(rotation.y, 
		atan2(-rotated_dir.x, -rotated_dir.z), 
		delta * ROTATION_SPEED)
		facing = -transform.basis.z

func coyote_timeout():
	jump_available = false

func has_input() -> bool:
	return Input.is_action_pressed("movement")

func just_dashed() -> void:
	dash_counter += 1

func can_dash() -> bool:
	var can_dash = power_up_controller.has_powerup("Dash")
	if can_dash:
		return can_dash_in_air()
	else:
		return false

func can_dash_in_air() -> bool:
	return dash_counter < MAX_DASHES_IN_AIR

func landed() -> void:
	dash_counter = 0
