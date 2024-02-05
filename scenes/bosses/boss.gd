extends CharacterBody2D
class_name Boss

var CAN_ATTACK: bool = false
var ATTACKS: Array[BossAttack]
var CURRENT_ATTACK: BossAttack
var CLOSE_PLAYERS_COUNT: int

var FIGHT_ONGOING: bool = true
signal boss_defeated

func _ready():
	$AnimatedSprite2D.play("idle")

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
	FIGHT_ONGOING = false
	boss_defeated.emit()
	queue_free()

func set_fight_ongoing(fight_ongoing: bool):
	FIGHT_ONGOING = fight_ongoing
