extends CharacterBody2D
class_name Boss

var CAN_ATTACK: bool = false
var ATTACKS: Array[BossAttack]
var CURRENT_ATTACK: BossAttack

func _ready():
	$AnimatedSprite2D.play("idle")

func attack():
	CAN_ATTACK = false

func _on_health_component_death_signal():
	# TODO: Handle Level Complete: You win screen, Boss Death Animation
	queue_free()

func _on_attack_cooldown_timeout():
	#print("can attack")
	CAN_ATTACK = true
