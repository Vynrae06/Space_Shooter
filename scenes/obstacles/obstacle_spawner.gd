extends Node2D

@export var MARKERS: Array[Marker2D]
@export var OBSTACLE_SCENE: PackedScene
@export var ALLOWED_TO_SPAWN: bool = true

var CAN_SPAWN_COOLDOWN_READY: bool = true
var FIGHT_ONGOING: bool = true

func _ready():
	hold_spawning()

func _process(_delta):
	if ALLOWED_TO_SPAWN and CAN_SPAWN_COOLDOWN_READY and FIGHT_ONGOING:
		print(FIGHT_ONGOING)
		hold_spawning()
		var obstacle = OBSTACLE_SCENE.instantiate() as ObstacleDestroyable
		obstacle.set_spawn_position(MARKERS.pick_random().position)
		$ObstaclesHolder.add_child(obstacle)

func hold_spawning():
	$SpawnTimer.start()
	CAN_SPAWN_COOLDOWN_READY = false

func _on_spawn_timer_timeout():
	CAN_SPAWN_COOLDOWN_READY = true

func _on_level_fight_over():
	FIGHT_ONGOING = false
	

