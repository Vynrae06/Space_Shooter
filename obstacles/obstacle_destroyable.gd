extends Area2D
class_name ObstacleDestroyable

func _ready():
	$SelfDestructTimer.start()

func set_spawn_position(spawn_position: Vector2):
	position = spawn_position

func _on_self_destruct_timer_timeout():
	queue_free()

func _on_health_component_death_signal():
	queue_free()
