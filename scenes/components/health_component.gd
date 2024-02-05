extends Node
class_name HealthComponent

@export var HEALTH: int
signal death_signal

func take_damage(damage: int) -> void:
	HEALTH -= damage
	if(HEALTH <= 0):
		death_signal.emit()

func can_take_damage() -> bool:
	return HEALTH > 0
