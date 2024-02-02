extends Boss
class_name BossUFO

func _ready():
	super._ready()
	ATTACKS.append($BossAttackHorizontal)
	ATTACKS.append($BossAttackVertical)
	$AttackCooldown.start()

func _process(_delta):
	if CAN_ATTACK && !ATTACKS.is_empty():
		CURRENT_ATTACK = ATTACKS.pick_random()
		attack()
		
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
