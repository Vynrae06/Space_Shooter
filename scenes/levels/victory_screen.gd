extends Control

func _ready():
	var win_time_text: String
	if Global.WIN_TIME.is_empty():
		win_time_text = "00:00:00"
	else:
		win_time_text = Global.WIN_TIME
	$WinTimeLabel.text = win_time_text

func _on_reset_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
