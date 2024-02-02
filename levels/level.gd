extends Node2D
class_name Level

var GAME_PAUSED: bool = false
@export var COUNTDOWN : float = 3.0 

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

func get_win_time() -> float:
	return FIGHT_TIMER - COUNTDOWN

func _on_boss_ufo_boss_defeated():
	fight_over.emit()
	print(get_win_time())

func register_player_death():
	PLAYERS_ALIVE_COUNT -= 1
	# TODO: Continue here, check if players are 0 and signal that the game is over
