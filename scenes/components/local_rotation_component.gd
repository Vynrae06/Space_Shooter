extends Node

@export var NODE2D: Node2D
@export var MIN_ROTATION_SPEED: float
@export var MAX_ROTATION_SPEED: float
var ROTATE_CLOCKWISE: bool = true
var ROTATION_SPEED: float

func _ready():
	ROTATE_CLOCKWISE = [true,false].pick_random()
	ROTATION_SPEED = randf_range(MIN_ROTATION_SPEED, MAX_ROTATION_SPEED)

func _process(delta):
	if ROTATE_CLOCKWISE:
		NODE2D.rotate(ROTATION_SPEED * delta)
	else:
		NODE2D.rotate(-ROTATION_SPEED * delta)
