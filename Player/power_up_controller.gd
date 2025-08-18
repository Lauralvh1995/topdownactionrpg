extends Node
class_name PowerUpController

@export var powerup_collection : Array[PowerUp]

func collect_powerup(new_powerup : PowerUp) -> void:
	if powerup_collection.has(new_powerup):
		return
	powerup_collection.append(new_powerup)

func has_powerup(powerup_name : String) -> bool:
	for powerup in powerup_collection:
		if powerup.name == powerup_name:
			return true
	return false
