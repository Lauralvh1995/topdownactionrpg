extends BaseState
class_name IdleState

@export_category("Parameters")

@export_category("Exit States")
@export var move_state : BaseState
@export var jump_state : BaseState
@export var fall_state : BaseState
@export var dash_state : BaseState

func enter() -> void :
	super()
	animation_controller.enter_idle()

func input(event: InputEvent) -> BaseState:
	if body.has_input():
		return move_state
	
	if event.is_action_pressed("jump"):
		return jump_state
	
	if event.is_action_pressed("dash") && body.can_dash():
		return dash_state
	
	return null

func physics_process(delta: float) -> BaseState:
	if not body.is_on_floor():
		return fall_state
	else:
		body.jump_available = true
	
	return null
