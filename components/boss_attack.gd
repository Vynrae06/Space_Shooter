extends Node2D
class_name BossAttack

func execute_attack(animation_name: String):
	$BossAttackSprite.visible = true
	$AnimationPlayer.play(animation_name)
	
func stop_attack():
	$BossAttackSprite.visible = false
	$AnimationPlayer.stop()

func play_animation(animation_name: String):
	$AnimationPlayer.play(animation_name)
