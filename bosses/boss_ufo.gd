extends Boss
class_name BossUFO

#TODO: Move all of the attacking into the boss attack component

var CAN_ATTACK: bool = false

func _ready():
	super._ready()
	$HorizontalAttackCooldown.start()

func _process(_delta):
	if CAN_ATTACK:
		attack()
	
func attack():
	CAN_ATTACK = false
	$HorizontalAttackLength.start()
	$OscillationMovementComponent.set_process(false)
	$BossAttackHorizontal/AnimationPlayer.play("laser_beam")
	# TODO: Turn the collider on at a frame of the attack

func _on_basic_attack_length_timer_timeout():
	$BossAttackHorizontal/AnimationPlayer.stop()
	$HorizontalAttackCooldown.start()
	$OscillationMovementComponent.set_process(true)

func _on_basic_attack_cooldown_timer_timeout():
	CAN_ATTACK = true
