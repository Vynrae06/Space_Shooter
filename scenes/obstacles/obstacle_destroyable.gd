extends Area2D
class_name ObstacleDestroyable

func _ready():
	$SelfDestructTimer.start()

func set_spawn_position(spawn_position: Vector2):
	position = spawn_position

func _on_self_destruct_timer_timeout():
	queue_free()

func _on_health_component_death_signal():
	$DestroyedSFX.play()
	get_node("CollisionShape2D").set_deferred("disabled", true)
	get_node("HurtBoxComponent/CollisionShape2D").set_deferred("disabled", true)
	$AnimatedSprite2D.visible = false

func _on_destroyed_sfx_finished():
	queue_free()
