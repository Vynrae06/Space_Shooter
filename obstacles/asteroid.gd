extends Obstacle
class_name Asteroid

@export var SPEED: float
var DIRECTION: Vector2
var PLAYER_POSITION: Vector2

func _ready():
	# TODO: Update the code to take into consideration both players.
	PLAYER_POSITION = get_tree().get_nodes_in_group("Player")[0].position
	DIRECTION = (PLAYER_POSITION - position).normalized()
	pass

func _physics_process(delta):
	print(PLAYER_POSITION)
	print(SPEED * delta)
	position += DIRECTION * SPEED * delta
	# TODO: Destroy after x time
	# Problem with this is that the Asteroid stops at the player's saved spot
	# position = position.move_toward(PLAYER_POSITION, SPEED * delta)
	pass
