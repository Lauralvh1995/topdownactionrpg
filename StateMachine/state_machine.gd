extends Node
class_name StateMachine

var current_state : BaseState
@export var body : CharacterBody3D
@export var default_state : BaseState

func change_state(new_state : BaseState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

func initialize() -> void:
	for child in get_children():
		child.body = body
		child.initialize()
	
	change_state(default_state)

func _physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state != null:
		change_state(new_state)

func _input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state != null:
		change_state(new_state)
