extends ObstacleDestroyable
class_name Asteroid

@export var SPEED: float
var DIRECTION: Vector2
var PLAYER_POSITION: Vector2

func _ready():
	PLAYER_POSITION = get_tree().get_nodes_in_group("Player").pick_random().position
	DIRECTION = (PLAYER_POSITION - position).normalized()

func _physics_process(delta):
	position += DIRECTION * SPEED * delta
