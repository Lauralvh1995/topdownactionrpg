extends BaseState
class_name DashState

@export_category("Parameters")
var dash_speed : float
var dash_length : float

@export_category("Exit States")
@export var move_state : BaseState
@export var idle_state : BaseState
@export var fall_state : BaseState

var is_dashing : bool = false

signal just_dashed

func initialize() -> void:
	dash_speed = body.DASH_SPEED
	dash_length = body.DASH_LENGTH

func enter() -> void:
	if not is_dashing:
		super()
		body.velocity.x = dash_speed * body.facing.x
		body.velocity.z = dash_speed * body.facing.z
		body.velocity.y = 0
		is_dashing = true
		just_dashed.emit()
		get_tree().create_timer(dash_length).timeout.connect(stop_dash)

func physics_process(delta: float) -> BaseState:
	body.move_and_slide()
	if not is_dashing:
		if body.has_input() && body.is_on_floor():
			return move_state
		elif body.is_on_floor():
			return idle_state
		else:
			return fall_state
	return null

func stop_dash():
	is_dashing = false
