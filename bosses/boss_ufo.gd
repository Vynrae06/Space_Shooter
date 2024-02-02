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
	$BossAttackHorizontal/BossAttackSprite.visible = true
	$BossAttackHorizontal/AnimationPlayer.play("laser_beam")

func _on_basic_attack_length_timer_timeout():
	$BossAttackHorizontal/AnimationPlayer.stop()
	$HorizontalAttackCooldown.start()
	$BossAttackHorizontal/BossAttackSprite.visible = false
	$OscillationMovementComponent.set_process(true)

func _on_basic_attack_cooldown_timer_timeout():
	CAN_ATTACK = true
