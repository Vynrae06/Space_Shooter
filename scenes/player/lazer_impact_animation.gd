extends Node2D

func _ready():
	$AnimatedSprite2D.play("default")
	modulate = Color(randf_range(0,1), randf_range(0,1), randf_range(0,1))

func _on_animated_sprite_2d_animation_finished():
	queue_free()
