extends Area2D
class_name ObstacleDestroyable
var destroyed_particles = preload("res://scenes/obstacles/obstacle_destroyed_particles.tscn")

func _ready():
	$SelfDestructTimer.start()

func set_spawn_position(spawn_position: Vector2):
	position = spawn_position

func destroy_self():
	#$DestroyedSFX.play()
	get_node("CollisionShape2D").set_deferred("disabled", true)
	get_node("HurtBoxComponent/CollisionShape2D").set_deferred("disabled", true)
	$AnimatedSprite2D.visible = false
	
	var destroyed_particles_instance = destroyed_particles.instantiate() as GPUParticles2D
	get_parent().add_child(destroyed_particles_instance)
	destroyed_particles_instance.global_position = position
	destroyed_particles_instance.emitting = true

func _on_self_destruct_timer_timeout():
	queue_free()

func _on_health_component_death_signal():
	destroy_self()

func _on_destroyed_sfx_finished():
	pass
