extends BaseState
class_name MoveState

@export_category("Parameters")
var movement_speed : float
var coyote_time : float
var fall_gravity : float

@export_category("Exit States")
@export var idle_state : BaseState
@export var jump_state : BaseState
@export var fall_state : BaseState
@export var dash_state : BaseState

func initialize() -> void:
	movement_speed = body.speed
	coyote_time = body.COYOTE_TIME
	fall_gravity = body.fall_gravity

func enter() -> void :
	super()
	animation_controller.enter_move()

func input(event: InputEvent) -> BaseState:
	if event.is_action_pressed("jump"):
		return jump_state
	
	if event.is_action_pressed("dash") && body.can_dash():
		return dash_state
	
	if !body.has_input():
		return idle_state
	
	return null

func physics_process(delta: float) -> BaseState:
	if not body.is_on_floor():
		if body.jump_available:
			get_tree().create_timer(coyote_time).timeout.connect(body.coyote_timeout)
		else:
			body.velocity.y -= fall_gravity * delta
	else:
		body.jump_available = true

	body.velocity.x = body.rotated_dir.x * movement_speed
	body.velocity.z = body.rotated_dir.z * movement_speed
	
	body.move_and_slide()
	
	if body.velocity.y < 0:
		return fall_state
	
	return null
