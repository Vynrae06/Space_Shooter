extends Node

@export var NODE2D: Node2D
@export var ROTATION_SPEED: float = 1
var ROTATE_CLOCKWISE: bool = true

func _ready():
	ROTATE_CLOCKWISE = bool(randi() % 2)

func _process(delta):
	if ROTATE_CLOCKWISE:
		NODE2D.rotate(ROTATION_SPEED * delta)
	else:
		NODE2D.rotate(-ROTATION_SPEED * delta)
