extends Node
class_name AnimationController

@export var animation_tree : AnimationTree

func enter_idle() -> void:
	animation_tree["parameters/IdleMove/blend_amount"] = 0
	
func enter_move() -> void:
	animation_tree["parameters/IdleMove/blend_amount"] = 1
	
func enter_jump() -> void:
	animation_tree["parameters/IdleMove/blend_amount"] = 0
	animation_tree["parameters/GroundAir/blend_amount"] = 1
	var state_machine : AnimationNodeStateMachine = animation_tree.get("parameters/Jump")
	if state_machine != null:
		state_machine.travel("Jump_Start")

func land() -> void:
	animation_tree["parameters/GroundAir/blend_amount"] = 0
	animation_tree["parameters/Jump/conditions/Land"] = true
	get_tree().create_timer(0.2).timeout.connect(finish_landing_animation)

func dead() -> void:
	pass

func attack() -> void:
	animation_tree["parameters/Attack/Request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE

func finish_landing_animation() -> void:
	animation_tree["parameters/Jump/conditions/Land"] = false
