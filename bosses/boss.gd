extends CharacterBody2D

func _ready():
	$AnimatedSprite2D.play("idle")

func _on_health_component_death_signal():
	queue_free()
