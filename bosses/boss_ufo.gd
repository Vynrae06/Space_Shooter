extends Boss
class_name BossUFO

var CAN_ATTACK: bool = false

func _ready():
	super._ready()
	$BasicAttackCooldownTimer.start()

func _process(_delta):
	if CAN_ATTACK:
		attack()
	
func attack():
	CAN_ATTACK = false
	$BasicAttackLengthTimer.start()
	$OscillationMovementComponent.set_process(false)

func _on_basic_attack_length_timer_timeout():
	$BasicAttackCooldownTimer.start()
	$OscillationMovementComponent.set_process(true)

func _on_basic_attack_cooldown_timer_timeout():
	CAN_ATTACK = true
