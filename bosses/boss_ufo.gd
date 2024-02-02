extends Boss
class_name BossUFO

func _ready():
	super._ready()
	ATTACKS.append($BossAttackHorizontal)
	ATTACKS.append($BossAttackVertical)
	$AttackCooldown.start()

func _process(_delta):
	if FIGHT_ONGOING:
		if CAN_ATTACK && !ATTACKS.is_empty():
			if is_a_player_close():
				CURRENT_ATTACK = $BossAttackVertical
			else:
				CURRENT_ATTACK = $BossAttackHorizontal
			attack()
	else:
		$OscillationMovementComponent.set_process(false)
		
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

func _on_level_fight_over():
	FIGHT_ONGOING = false
