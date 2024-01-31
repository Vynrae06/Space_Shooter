extends Node
class_name HealthComponent

@export var health: int

func take_damage(damage: int) -> void:
	health -= damage

func is_dead() -> bool:
	return health <= 0

func can_take_damage() -> bool:
	return health > 0
