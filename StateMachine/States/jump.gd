extends BaseState
class_name JumpState

@export_category("Parameters")
var movement_speed : float
var jump_gravity : float
var jump_velocity : float

@export_category("Exit States")
@export var fall_state : BaseState
@export var idle_state : BaseState
@export var move_state : BaseState
@export var dash_state : BaseState

signal landed

func initialize() -> void:
	movement_speed = body.speed
	jump_gravity = body.jump_gravity
	jump_velocity = body.jump_velocity
	print(jump_velocity)

func enter() -> void:
	super()
	body.velocity.y = jump_velocity
	animation_controller.enter_jump()

func input(event : InputEvent) -> BaseState:
	if event.is_action_pressed("dash") && body.can_dash():
		return dash_state
	
	return null

func physics_process(delta: float) -> BaseState:
	body.velocity.x = body.rotated_dir.x * movement_speed
	body.velocity.z = body.rotated_dir.z * movement_speed
	body.velocity.y -= jump_gravity * delta
	
	body.move_and_slide()
	
	if body.velocity.y < 0:
		return fall_state
	
	if body.is_on_floor():
		landed.emit()
		if body.has_input():
			return move_state
		else:
			return idle_state
	
	return null
