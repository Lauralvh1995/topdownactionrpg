extends Node
class_name BaseState

@export_category("Parameters")
@export_category("Exit States")

var body : CharacterBody3D
var animation_controller : AnimationController

func initialize() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func input(event: InputEvent) -> BaseState:
	return null

func process(delta: float) -> BaseState:
	return null

func physics_process(delta: float) -> BaseState:
	return null
