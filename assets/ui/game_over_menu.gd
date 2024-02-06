extends Control

func _ready():
	$VBoxContainer/RestartButton.grab_focus()

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func _on_exit_button_pressed():
	get_tree().quit ()
