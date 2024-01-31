extends Area2D
class_name HurtBoxComponent

@export var HEALTH_COMPONENT: HealthComponent
@export var ANIMATION_PLAYER: AnimationPlayer

func _on_area_entered(projectile):
	if HEALTH_COMPONENT.can_take_damage():
		HEALTH_COMPONENT.take_damage(projectile.DAMAGE)
		ANIMATION_PLAYER.play("hit_flash")
