extends CharacterBody2D
class_name Boss

var CAN_ATTACK: bool = false
var ATTACKS: Array[BossAttack]
var CURRENT_ATTACK: BossAttack
var CLOSE_PLAYERS_COUNT: int

signal boss_defeated

func _ready():
	$SpriteAnimationPlayer.play("idle")

func attack():
	CAN_ATTACK = false

func _on_attack_cooldown_timeout():
	CAN_ATTACK = true

func _on_player_proximity_detector_area_entered(_area):
	CLOSE_PLAYERS_COUNT+= 1

func _on_player_proximity_detector_area_exited(_area):
	CLOSE_PLAYERS_COUNT -=1

func is_a_player_close() -> bool:
	return CLOSE_PLAYERS_COUNT > 0

func _on_health_component_death_signal():
	Global.FIGHT_ONGOING = false
	boss_defeated.emit()
	queue_free()
