extends ObstacleDestroyable
class_name Asteroid

@export var SPEED: float
var DIRECTION: Vector2
var PLAYER_POSITION: Vector2
var Colors = [Color(1,1,1,1), Color.RED, Color.YELLOW, Color.PINK]

func _ready():
	PLAYER_POSITION = get_tree().get_nodes_in_group("player").pick_random().position
	DIRECTION = (PLAYER_POSITION - position).normalized()
	modulate = Colors.pick_random()

func _physics_process(delta):
	position += DIRECTION * SPEED * delta
