extends CharacterBody2D
class_name Boss

func _ready():
	# $AnimatedSprite2D.play("idle")
	pass

func _on_health_component_death_signal():
	# TODO: Handle Level Complete: You win screen, Boss Death Animation
	queue_free()
