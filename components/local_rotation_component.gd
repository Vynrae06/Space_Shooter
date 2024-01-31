extends Node

@export var RIGID_BODY: RigidBody2D
@export var ROTATION_SPEED: float = 1
var ROTATE_CLOCKWISE: bool = true

func _ready():
	ROTATE_CLOCKWISE = bool(randi() % 2)

func _process(delta):
	if ROTATE_CLOCKWISE:
		RIGID_BODY.rotate(ROTATION_SPEED * delta)
	else:
		RIGID_BODY.rotate(-ROTATION_SPEED * delta)
