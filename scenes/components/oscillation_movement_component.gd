extends Node

@export var FREQUENCY: float
@export var AMPLITUDE: float
@export var CHARACTER_BODY_2D: CharacterBody2D

var TIME: float = 0

func _process(delta):
	TIME+= delta
	move(delta)

func move(delta):
	CHARACTER_BODY_2D.position.y += cos(TIME * FREQUENCY) * AMPLITUDE * delta
