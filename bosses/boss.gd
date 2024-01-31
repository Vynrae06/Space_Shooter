extends CharacterBody2D
	
func _ready():
	$AnimatedSprite2D.play("idle")
	$AnimatedSprite2D.modulate = Color.WHITE
