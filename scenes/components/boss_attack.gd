extends Node2D
class_name BossAttack

@export var ANIMATION_NAME: String

func execute_attack():
	$BossAttackSprite.visible = true
	$AnimationPlayer.play(ANIMATION_NAME)
	
func stop_attack():
	$BossAttackSprite.visible = false
	$AnimationPlayer.stop()
