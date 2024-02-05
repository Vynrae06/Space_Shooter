extends Node2D
class_name Level

var GAME_PAUSED: bool = false
@export var COUNTDOWN : float

var FIGHT_TIMER: float
var PLAYERS_ALIVE_COUNT: int
var BOSS_UFO_SCENE = preload("res://scenes/bosses/boss_ufo.tscn")
var FIGHT_ONGOING = true
var BOSS_UFO: Boss

signal fight_over

func _process(delta):
	FIGHT_TIMER+= delta
	# Check how many players are left
	if get_tree().get_nodes_in_group("player").size() <= 0:
		fight_over.emit()
		FIGHT_ONGOING = false
		BOSS_UFO.set_fight_ongoing(false)

func get_win_time() -> String:
	var fight_duration : float = FIGHT_TIMER - COUNTDOWN
	var fight_duration_minutes : float = floor(fight_duration/60)
	var fight_duration_seconds : float = floori(fight_duration) % 60
	var fight_duration_milliseconds : float = round((fight_duration - floorf(fight_duration)) * 100)
	var fight_duration_formatted : String = "%02d:%02d:%02d" % [fight_duration_minutes, fight_duration_seconds, fight_duration_milliseconds]
	return fight_duration_formatted

func _on_boss_ufo_boss_defeated():
	fight_over.emit()
	print("Win Time:" + get_win_time())

func _on_spawn_ufo_minions_timer_timeout():
	if FIGHT_ONGOING:
		$UFOSpawner.ALLOWED_TO_SPAWN = true

func _on_begin_boss_fight_timer_timeout():
	if FIGHT_ONGOING:
		BOSS_UFO = BOSS_UFO_SCENE.instantiate()
		add_child(BOSS_UFO)
		BOSS_UFO.connect("boss_defeated", _on_boss_ufo_boss_defeated)
		BOSS_UFO.position.x = 705
		
