extends Boss
class_name BossUFO

#TODO: Move all of the attacking into the boss attack component

func _ready():
	super._ready()
	ATTACKS.append($BossAttackHorizontal)
	ATTACKS.append($BossAttackVertical)
	$AttackCooldown.start()

func _process(_delta):
	if CAN_ATTACK && !ATTACKS.is_empty():
		CURRENT_ATTACK = ATTACKS[0]
		attack()
		
func attack():
	super.attack()
	CURRENT_ATTACK.get_node("BossAttackDuration").start()
	$OscillationMovementComponent.set_process(false)
	CURRENT_ATTACK.execute_attack("laser_beam")

func _on_horizontal_boss_attack_timeout():
	$AttackCooldown.start()
	$OscillationMovementComponent.set_process(true)
	CURRENT_ATTACK.stop_attack()
