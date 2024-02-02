extends Node2D

@export var MARKERS: Array[Marker2D]
@export var OBSTACLE_SCENE: PackedScene
var CAN_SPAWN: bool = true
# TODO: Check if the fight is happening, which itself checks if both players are alive

func _ready():
	hold_spawning()

func _process(_delta):
	if CAN_SPAWN:
		hold_spawning()
		var obstacle = OBSTACLE_SCENE.instantiate() as ObstacleDestroyable
		obstacle.set_spawn_position(MARKERS.pick_random().position)
		$ObstaclesHolder.add_child(obstacle)

func hold_spawning():
	$SpawnTimer.start()
	CAN_SPAWN = false

func _on_spawn_timer_timeout():
	CAN_SPAWN = true
