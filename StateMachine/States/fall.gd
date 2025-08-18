extends BaseState
class_name FallState

@export_category("Parameters")
var movement_speed : float
var coyote_time : float
var jump_gravity : float
var fall_gravity : float

@export_category("Exit States")
@export var move_state : BaseState
@export var idle_state : BaseState
@export var dash_state : BaseState

signal landed

func initialize() -> void:
	movement_speed = body.speed
	coyote_time = body.COYOTE_TIME
	fall_gravity = body.fall_gravity
	jump_gravity = body.jump_gravity

func input(event: InputEvent) -> BaseState:
	if event.is_action_pressed("dash") && body.can_dash():
		return dash_state
	return null

func physics_process(delta: float) -> BaseState:
	if not body.is_on_floor():
		if body.jump_available:
			get_tree().create_timer(coyote_time).timeout.connect(body.coyote_timeout)
		if body.velocity.y > 0:
			body.velocity.y -= jump_gravity * delta
		else:
			body.velocity.y -= fall_gravity * delta
	
	body.move_and_slide()
	
	if body.is_on_floor():
		if body.has_input():
			return move_state
		else:
			return idle_state
	
	return null

func exit() -> void:
	landed.emit()
	animation_controller.land()
