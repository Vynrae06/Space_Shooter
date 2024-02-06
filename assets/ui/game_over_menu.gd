extends Control

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func _on_exit_button_pressed():
	get_tree().quit ()

func set_focus():
	$VBoxContainer/RestartButton.grab_focus()
