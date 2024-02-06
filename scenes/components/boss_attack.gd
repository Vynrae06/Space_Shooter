extends Node2D
class_name BossAttack

@export var ANIMATION_NAME: String

func execute_attack():
	$BossAttackSprite.visible = true
	$AnimationPlayer.play(ANIMATION_NAME)
	await get_tree().create_timer(1.0).timeout
	$BossAttackSFX.play()
	
func stop_attack():
	$BossAttackSprite.visible = false
	$AnimationPlayer.stop()
