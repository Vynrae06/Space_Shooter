extends Control

func _ready():
	$VBoxContainer/RestartButton.grab_focus()

func _on_restart_button_pressed():
	TransitionLayer.change_scene("res://scenes/levels/level.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
