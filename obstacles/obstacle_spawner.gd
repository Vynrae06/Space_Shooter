extends Node2D

@export var MARKERS: Array[Marker2D]
@export var OBSTACLE_SCENE: PackedScene
var CAN_SPAWN: bool = true

func _ready():
	hold_spawning()

func _process(_delta):
	if CAN_SPAWN:
		hold_spawning()
		var obstacle = OBSTACLE_SCENE.instantiate() as Obstacle
		obstacle.set_spawn_position(MARKERS[0].position)
		$ObstaclesHolder.add_child(obstacle)

func hold_spawning():
	$SpawnTimer.start()
	CAN_SPAWN = false

func _on_spawn_timer_timeout():
	CAN_SPAWN = true
