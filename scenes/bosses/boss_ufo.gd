extends Boss
class_name BossUFO

func _ready():
	super._ready()
	ATTACKS.append($BossAttackHorizontal)
	ATTACKS.append($BossAttackVertical)
	position.x = 705
	
	intro_start()
	await get_tree().create_timer(3.0).timeout
	intro_end()

func _process(_delta):
	if Global.FIGHT_ONGOING:
		if CAN_ATTACK && !ATTACKS.is_empty():
			if is_a_player_close():
				CURRENT_ATTACK = $BossAttackVertical
			else:
				CURRENT_ATTACK = $BossAttackHorizontal
			attack()
	else:
		$OscillationMovementComponent.set_process(false)
		get_node("HurtBoxComponent/CollisionShape2D").set_deferred("disabled", true)
		
	fixate_vertical_attack_position()
		
func intro_start():
	$IntroSFX.play()
	$OscillationMovementComponent.set_process(false)
	get_node("HurtBoxComponent/CollisionShape2D").set_deferred("disabled", true)
	$SpriteAnimationPlayer.play("flash_in")
	$SpriteAnimationPlayer.queue("idle")

func intro_end():
	$AttackCooldown.start()
	$OscillationMovementComponent.set_process(true)
	get_node("HurtBoxComponent/CollisionShape2D").set_deferred("disabled", false)
	
func attack():
	super.attack()
	CURRENT_ATTACK.get_node("BossAttackDuration").start()
	$OscillationMovementComponent.set_process(false)
	CURRENT_ATTACK.execute_attack()

func _on_horizontal_boss_attack_timeout():
	stop_attack()

func _on_boss_attack_duration_timeout():
	stop_attack()

func stop_attack():
	$AttackCooldown.start()
	$OscillationMovementComponent.set_process(true)
	CURRENT_ATTACK.stop_attack()
	
func fixate_vertical_attack_position():
	$BossAttackVertical.global_position = Vector2(780, 0)
