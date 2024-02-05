extends Node2D
class_name Level

var GAME_PAUSED: bool = false
@export var COUNTDOWN : float

var FIGHT_TIMER: float
var PLAYERS_ALIVE_COUNT: int

signal fight_over

func _ready():
	var players = get_tree().get_nodes_in_group("player") as Array[Player]
	PLAYERS_ALIVE_COUNT = players.size()
	for player in players:
		player.connect("player_died", register_player_death)

func _process(delta):
	FIGHT_TIMER+= delta

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

func register_player_death():
	PLAYERS_ALIVE_COUNT -= 1
	if PLAYERS_ALIVE_COUNT <= 0:
		fight_over.emit()

func _on_spawn_ufo_minions_timer_timeout():
	$UFOSpawner.ALLOWED_TO_SPAWN = true


func _on_begin_boss_fight_timer_timeout():
	pass # Replace with function body.
