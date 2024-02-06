extends Node2D
class_name Level

var GAME_PAUSED: bool = false
@export var COUNTDOWN : float

var FIGHT_TIMER: float
var PLAYERS_ALIVE_COUNT: int
var BOSS_UFO_SCENE = preload("res://scenes/bosses/boss_ufo.tscn")
var BOSS_UFO: Boss

func _ready():	
	scene_intro()
	await get_tree().create_timer(COUNTDOWN).timeout
	start_fight()

func _process(delta):
	FIGHT_TIMER+= delta
	check_players_alive()

func scene_intro():
	Global.FIGHT_ONGOING = false
	$OverlayAnimations/AnimationPlayer.play("ready")
	$OverlayAnimations/AnimationPlayer.queue("go")
	await get_tree().create_timer(1.8).timeout
	$OverlayAnimations/FightStartEndSFX.play()

func start_fight():
	Global.FIGHT_ONGOING = true
	
func check_players_alive():
	if get_tree().get_nodes_in_group("player").size() <= 0:
		Global.FIGHT_ONGOING = false

func get_win_time() -> String:
	var fight_duration : float = FIGHT_TIMER - COUNTDOWN
	var fight_duration_minutes : float = floor(fight_duration/60)
	var fight_duration_seconds : float = floori(fight_duration) % 60
	var fight_duration_milliseconds : float = round((fight_duration - floorf(fight_duration)) * 100)
	var fight_duration_formatted : String = "%02d:%02d:%02d" % [fight_duration_minutes, fight_duration_seconds, fight_duration_milliseconds]
	return fight_duration_formatted

func _on_boss_ufo_boss_defeated():
	$OverlayAnimations/AnimationPlayer.play("victory")
	$OverlayAnimations/FightStartEndSFX.play()
	print("Win Time:" + get_win_time())

func _on_spawn_ufo_minions_timer_timeout():
	if Global.FIGHT_ONGOING:
		$UFOSpawner.ALLOWED_TO_SPAWN = true

func _on_begin_boss_fight_timer_timeout():
	if Global.FIGHT_ONGOING:
		BOSS_UFO = BOSS_UFO_SCENE.instantiate()
		add_child(BOSS_UFO)
		BOSS_UFO.connect("boss_defeated", _on_boss_ufo_boss_defeated)
