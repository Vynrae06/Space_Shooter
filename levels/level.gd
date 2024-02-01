extends Node2D

var GAME_PAUSED: bool = false

#func _process(_delta):
	#if Input.is_action_just_pressed("start_pause"):
		#get_tree().paused = !get_tree().paused
